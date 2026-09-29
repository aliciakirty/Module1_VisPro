import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/drama.dart';

class DramaRepository {
  static const String _storageKey = 'dramas';

  final SharedPreferencesAsync _prefs =
  SharedPreferencesAsync();

  bool _loaded = false;

  List<Drama> _items = [
    const Drama(
      id: '1',
      title: 'Twinkling Watermelon',
      genre: ['Romance', 'Youth'],
      year: 2023,
      episodes: 16,
      watchedEpisodes: {
        1, 2, 3, 4, 5, 6, 7, 8,
        9, 10, 11, 12, 13, 14, 15, 16,
      },
      status: DramaStatus.finished,
      rating: 5,
      description:
      'A music-loving student travels through time '
          'and meets his father as a teenager.',
    ),
    const Drama(
      id: '2',
      title: 'Moving',
      genre: ['Action', 'Fantasy'],
      year: 2023,
      episodes: 20,
      watchedEpisodes: {
        1, 2, 3, 4, 5, 6,
        7, 8, 9, 10, 11, 12,
      },
      status: DramaStatus.watching,
      rating: null,
      description:
      'Teenagers with hidden superpowers uncover '
          'the extraordinary histories of their parents.',
    ),
    const Drama(
      id: '3',
      title: 'Queen of Tears',
      genre: ['Romance', 'Drama'],
      year: 2024,
      episodes: 16,
      watchedEpisodes: {},
      status: DramaStatus.backlog,
      rating: null,
      description:
      'A married couple faces a crisis while '
          'rediscovering what brought them together.',
    ),
    const Drama(
      id: '4',
      title: 'Alchemy of Souls',
      genre: ['Fantasy', 'Romance'],
      year: 2022,
      episodes: 20,
      watchedEpisodes: {
        1, 2, 3, 4, 5,
        6, 7, 8, 9, 10,
        11, 12, 13, 14, 15,
        16, 17, 18, 19, 20,
      },
      status: DramaStatus.finished,
      rating: 4.5,
      description:
      'Mages and warriors navigate a world shaped '
          'by a forbidden soul-shifting magic.',
    ),
  ];

  Future<void> _load() async {
    if (_loaded) return;

    final savedData =
    await _prefs.getStringList(_storageKey);

    if (savedData != null) {
      _items = savedData
          .map(
            (item) => Drama.fromJson(
          jsonDecode(item) as Map<String, dynamic>,
        ),
      )
          .toList();
    }

    _loaded = true;
  }

  Future<void> _save() async {
    final data = _items
        .map(
          (drama) => jsonEncode(drama.toJson()),
    )
        .toList();

    await _prefs.setStringList(
      _storageKey,
      data,
    );
  }

  Future<List<Drama>> getDramas() async {
    await _load();

    return List.unmodifiable(_items);
  }

  Future<void> add(Drama drama) async {
    await _load();

    _items.add(drama);

    await _save();
  }

  Future<void> update(Drama drama) async {
    await _load();

    final index = _items.indexWhere(
          (item) => item.id == drama.id,
    );

    if (index != -1) {
      _items[index] = drama;
      await _save();
    }
  }

  Future<void> toggleEpisode(
      String dramaId,
      int episode,
      ) async {
    await _load();

    final index = _items.indexWhere(
          (item) => item.id == dramaId,
    );

    if (index == -1) return;

    final drama = _items[index];

    final watchedEpisodes = <int>{
      ...drama.watchedEpisodes,
    };

    if (watchedEpisodes.contains(episode)) {
      watchedEpisodes.remove(episode);
    } else {
      watchedEpisodes.add(episode);
    }

    final DramaStatus status;

    if (watchedEpisodes.isEmpty) {
      status = DramaStatus.backlog;
    } else if (watchedEpisodes.length >= drama.episodes) {
      status = DramaStatus.finished;
    } else {
      status = DramaStatus.watching;
    }

    _items[index] = drama.copyWith(
      watchedEpisodes: watchedEpisodes,
      status: status,
    );

    await _save();
  }
}
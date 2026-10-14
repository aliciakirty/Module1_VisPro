enum DramaStatus {
  backlog,
  watching,
  finished,
  dropped,
}

class Drama {
  const Drama({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.episodes,
    required this.watchedEpisodes,
    required this.status,
    required this.rating,
    required this.description,
  });

  final String id;
  final String title;
  final List<String> genre;
  final int year;
  final int episodes;
  final Set<int> watchedEpisodes;
  final DramaStatus status;
  final double? rating;
  final String description;

  int get watchedCount => watchedEpisodes.length;

  double get progress => episodes == 0 ? 0 : watchedCount / episodes;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'year': year,
      'episodes': episodes,
      'watchedEpisodes': watchedEpisodes.toList(),
      'status': status.name,
      'rating': rating,
      'description': description,
    };
  }

  factory Drama.fromJson(Map<String, dynamic> json) {
    return Drama(
      id: json['id'] as String,
      title: json['title'] as String,
      genre: List<String>.from(json['genre'] as List),
      year: json['year'] as int,
      episodes: json['episodes'] as int,
      watchedEpisodes: Set<int>.from(
        (json['watchedEpisodes'] as List).map(
              (episode) => episode as int,
        ),
      ),
      status: DramaStatus.values.firstWhere(
            (status) => status.name == json['status'],
        orElse: () => DramaStatus.backlog,
      ),
      rating: (json['rating'] as num?)?.toDouble(),
      description: json['description'] as String,
    );
  }

  Drama copyWith({
    String? title,
    int? episodes,
    Set<int>? watchedEpisodes,
    DramaStatus? status,
    double? rating,
  }) {
    final totalEpisodes = episodes ?? this.episodes;

    final validWatched = (watchedEpisodes ?? this.watchedEpisodes)
        .where(
          (episode) => episode >= 1 && episode <= totalEpisodes,
    )
        .toSet();

    return Drama(
      id: id,
      title: title ?? this.title,
      genre: genre,
      year: year,
      episodes: totalEpisodes,
      watchedEpisodes: Set.unmodifiable(validWatched),
      status: status ?? this.status,
      rating: rating ?? this.rating,
      description: description,
    );
  }
}
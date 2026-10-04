import 'package:flutter/material.dart';

import '../../data/drama_repository.dart';
import '../../domain/models/drama.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.drama,
    required this.repository,
    required this.onUpdated,
  });

  final Drama drama;
  final DramaRepository repository;
  final VoidCallback onUpdated;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Set<int> _watchedEpisodes;

  @override
  void initState() {
    super.initState();
    _watchedEpisodes = {...widget.drama.watchedEpisodes};
  }

  Future<void> _toggleEpisode(int episode) async {
    await widget.repository.toggleEpisode(
      widget.drama.id,
      episode,
    );

    if (!mounted) return;

    setState(() {
      if (_watchedEpisodes.contains(episode)) {
        _watchedEpisodes.remove(episode);
      } else {
        _watchedEpisodes.add(episode);
      }
    });

    widget.onUpdated();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.drama.episodes;
    final watched = _watchedEpisodes.length;
    final progress = total == 0 ? 0.0 : watched / total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drama Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Text(
              widget.drama.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${widget.drama.year} • ${widget.drama.genre.join(' • ')}',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: progress,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$watched of $total episodes watched',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Episodes',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 8),

          Text(
            'Tap an episode after you finish watching it. '
                'Your progress updates automatically.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 8),

          ...List.generate(total, (index) {
            final episode = index + 1;
            final isWatched = _watchedEpisodes.contains(episode);

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: CheckboxListTile(
                value: isWatched,
                onChanged: (_) => _toggleEpisode(episode),
                title: Text('Episode $episode'),
                secondary: Icon(
                  isWatched
                      ? Icons.check_circle
                      : Icons.play_circle_outline,
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          Text(widget.drama.description),
        ],
      ),
    );
  }
}
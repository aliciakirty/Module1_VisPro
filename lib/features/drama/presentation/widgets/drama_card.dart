import 'package:flutter/material.dart';

import '../../domain/models/drama.dart';

class DramaCard extends StatelessWidget {
  const DramaCard({super.key, required this.drama, required this.onTap});

  final Drama drama;
  final VoidCallback onTap;

  String get statusLabel {
    switch (drama.status) {
      case DramaStatus.backlog: return 'Backlog';
      case DramaStatus.watching: return 'Watching';
      case DramaStatus.finished: return 'Finished';
      case DramaStatus.dropped: return 'Dropped';
    }
  }

  Color statusColor(BuildContext context) {
    switch (drama.status) {
      case DramaStatus.backlog:
        return Colors.orange;
      case DramaStatus.watching:
        return Colors.green;
      case DramaStatus.finished:
        return Theme.of(context).colorScheme.primary;
      case DramaStatus.dropped:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = statusColor(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      drama.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Chip(
                    backgroundColor: color.withValues(alpha: 0.12),
                    side: BorderSide(
                      color: color.withValues(alpha: 0.5),
                    ),
                    label: Text(
                      statusLabel,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('${drama.year} • ${drama.genre.join(' • ')}'),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: drama.progress,
              ),
              const SizedBox(height: 6),
              Text(
                '${drama.watchedCount}/${drama.episodes} episodes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
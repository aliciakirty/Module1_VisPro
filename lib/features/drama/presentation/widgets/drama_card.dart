import 'package:flutter/material.dart';

import '../../domain/models/drama.dart';

class DramaCard extends StatelessWidget {
  const DramaCard({
    super.key,
    required this.drama,
    required this.onTap,
  });

  final Drama drama;
  final VoidCallback onTap;

  String get statusLabel {
    switch (drama.status) {
      case DramaStatus.backlog:
        return 'Backlog';
      case DramaStatus.watching:
        return 'Watching';
      case DramaStatus.finished:
        return 'Finished';
      case DramaStatus.dropped:
        return 'Dropped';
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

  Widget _buildStatusChip(Color color) {
    return Chip(
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(
        color: color.withValues(alpha: 0.5),
      ),
      label: Text(
        statusLabel,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = statusColor(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 320;

              final title = Text(
                drama.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: textTheme.titleMedium,
              );

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isNarrow) ...[
                    title,
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _buildStatusChip(color),
                    ),
                  ] else
                    Row(
                      children: [
                        Expanded(
                          child: title,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _buildStatusChip(color),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 6),
                  Text(
                    '${drama.year} • ${drama.genre.join(' • ')}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: drama.progress,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${drama.watchedCount}/${drama.episodes} episodes',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
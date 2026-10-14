import 'package:flutter/material.dart';

import '../../data/drama_repository.dart';
import '../../domain/models/drama.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({
    super.key,
    required this.repository,
    required this.onSaved,
  });

  final DramaRepository repository;
  final VoidCallback onSaved;

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final _titleController = TextEditingController();
  final _episodesController = TextEditingController(text: '1');

  DramaStatus _status = DramaStatus.watching;

  @override
  void dispose() {
    _titleController.dispose();
    _episodesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();

    final totalEpisodes = int.tryParse(
      _episodesController.text.trim(),
    );

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a drama title.'),
        ),
      );
      return;
    }

    if (totalEpisodes == null || totalEpisodes <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid total episode number.'),
        ),
      );
      return;
    }

    await widget.repository.add(
      Drama(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        genre: const ['Uncategorized'],
        year: DateTime.now().year,
        episodes: totalEpisodes,
        watchedEpisodes: {},
        status: _status,
        rating: null,
        description: 'Added from the personal watch log.',
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Drama added to your vault.'),
      ),
    );

    widget.onSaved();

    _titleController.clear();
    _episodesController.text = '1';

    setState(() {
      _status = DramaStatus.watching;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a Drama',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        keyboardDismissBehavior:
        ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Add a drama to your vault',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter the drama information. '
                'You can mark individual episodes as watched later.',
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Drama title',
              hintText: 'e.g. Queen of Tears',
              prefixIcon: Icon(Icons.movie_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _episodesController,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Total episodes',
              hintText: 'e.g. 16',
              prefixIcon: Icon(Icons.format_list_numbered),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<DramaStatus>(
            isExpanded: true,
            initialValue: _status,
            decoration: const InputDecoration(
              labelText: 'Status',
              prefixIcon: Icon(Icons.flag_outlined),
            ),
            items: DramaStatus.values.map(
                  (status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(
                    _statusLabel(status),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              setState(() {
                _status = value ?? DramaStatus.watching;
              });
            },
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.add),
            label: const Text(
              'Add to Vault',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(DramaStatus status) {
    switch (status) {
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
}
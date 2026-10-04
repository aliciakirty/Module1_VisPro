import 'package:flutter/material.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../../data/drama_repository.dart';
import '../../domain/models/drama.dart';
import '../widgets/drama_card.dart';
import '../widgets/drama_search.dart';
import '../widgets/status_filter.dart';
import '../widgets/collection_summary.dart';
import 'detail_screen.dart';
import 'log_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.repository});

  final DramaRepository repository;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;
  final _searchController = TextEditingController();
  String _query = '';
  DramaStatus? _status;
  late Future<List<Drama>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.repository.getDramas();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reload() => setState(() => _future = widget.repository.getDramas());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _CollectionPage(
            future: _future,
            controller: _searchController,
            query: _query,
            status: _status,
            onQueryChanged: (value) => setState(() => _query = value),
            onStatusChanged: (value) => setState(() => _status = value),
            onOpen: (drama) => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailScreen(drama: drama, repository: widget.repository, onUpdated: _reload),
            )),
          ),
          LogScreen(repository: widget.repository, onSaved: _reload),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.collections_bookmark_outlined), selectedIcon: Icon(Icons.collections_bookmark), label: 'Vault'),
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), selectedIcon: Icon(Icons.edit_note), label: 'Log'),
        ],
      ),
    );
  }
}

class _CollectionPage extends StatelessWidget {
  const _CollectionPage({required this.future, required this.controller, required this.query, required this.status, required this.onQueryChanged, required this.onStatusChanged, required this.onOpen});

  final Future<List<Drama>> future;
  final TextEditingController controller;
  final String query;
  final DramaStatus? status;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<DramaStatus?> onStatusChanged;
  final ValueChanged<Drama> onOpen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            centerTitle: true,
            title: const Center(
              child: Text(
                'K-Drama',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), child: DramaSearch(controller: controller, onChanged: onQueryChanged))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 0), child: StatusFilter(value: status, onChanged: onStatusChanged))),
          FutureBuilder<List<Drama>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.hasError) {
                return const SliverFillRemaining(child: Center(child: Text('Something went wrong.')));
              }
              final all = snapshot.data ?? [];
              final filtered = all.where((drama) {
                final matchesQuery = drama.title.toLowerCase().contains(query.toLowerCase());
                final matchesStatus = status == null || drama.status == status;
                return matchesQuery && matchesStatus;
              }).toList();
              if (all.isEmpty) {
                return const SliverFillRemaining(child: AppEmptyState(title: 'Your vault is empty', message: 'Add your first drama from the Log tab.'));
              }
              if (filtered.isEmpty) {
                return const SliverFillRemaining(child: AppEmptyState(icon: Icons.search_off, title: 'No matches found', message: 'Try another title or status filter.'));
              }
              final finished = all.where((item) => item.status == DramaStatus.finished).length;
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index == 0) return Padding(padding: const EdgeInsets.only(bottom: 12), child: CollectionSummary(total: all.length, finished: finished));
                    final drama = filtered[index - 1];
                    return Padding(padding: const EdgeInsets.only(bottom: 12), child: DramaCard(drama: drama, onTap: () => onOpen(drama)));
                  },
                  childCount: filtered.length + 1,
                )),
              );
            },
          ),
        ],
      ),
    );
  }
}

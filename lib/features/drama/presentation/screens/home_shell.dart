import 'package:flutter/material.dart';

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

  void _reload() {
    setState(() {
      _future = widget.repository.getDramas();
    });
  }

  void _openLog() {
    setState(() => _selectedIndex = 1);
  }

  void _clearFilters() {
    _searchController.clear();

    setState(() {
      _query = '';
      _status = null;
    });
  }

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
            onQueryChanged: (value) {
              setState(() => _query = value);
            },
            onStatusChanged: (value) {
              setState(() => _status = value);
            },
            onOpen: (drama) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailScreen(
                    drama: drama,
                    repository: widget.repository,
                    onUpdated: _reload,
                  ),
                ),
              );
            },
            onAddDrama: _openLog,
            onClearFilters: _clearFilters,
            onRetry: _reload,
          ),
          LogScreen(
            repository: widget.repository,
            onSaved: _reload,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.collections_bookmark_outlined),
            selectedIcon: Icon(Icons.collections_bookmark),
            label: 'Vault',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Log',
          ),
        ],
      ),
    );
  }
}

class _CollectionPage extends StatelessWidget {
  const _CollectionPage({
    required this.future,
    required this.controller,
    required this.query,
    required this.status,
    required this.onQueryChanged,
    required this.onStatusChanged,
    required this.onOpen,
    required this.onAddDrama,
    required this.onClearFilters,
    required this.onRetry,
  });

  final Future<List<Drama>> future;
  final TextEditingController controller;
  final String query;
  final DramaStatus? status;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<DramaStatus?> onStatusChanged;
  final ValueChanged<Drama> onOpen;
  final VoidCallback onAddDrama;
  final VoidCallback onClearFilters;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return CustomScrollView(
            keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              const SliverAppBar.large(
                centerTitle: true,
                title: Text(
                  'K-Drama',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DramaSearch(
                    controller: controller,
                    onChanged: onQueryChanged,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: StatusFilter(
                    value: status,
                    onChanged: onStatusChanged,
                  ),
                ),
              ),
              FutureBuilder<List<Drama>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: _HomeEmptyState(
                        icon: Icons.error_outline,
                        title: 'Unable to load your vault',
                        message:
                        'Something went wrong. Please try again.',
                        actionLabel: 'Retry',
                        onAction: onRetry,
                      ),
                    );
                  }

                  final all = snapshot.data ?? <Drama>[];

                  final filtered = all.where((drama) {
                    final matchesQuery = drama.title
                        .toLowerCase()
                        .contains(query.trim().toLowerCase());

                    final matchesStatus =
                        status == null || drama.status == status;

                    return matchesQuery && matchesStatus;
                  }).toList();
                  if (all.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: _HomeEmptyState(
                        icon: Icons.movie_creation_outlined,
                        title: 'Your vault is empty',
                        message:
                        'Add your first K-drama to start building your collection.',
                        actionLabel: 'Add a drama',
                        onAction: onAddDrama,
                      ),
                    );
                  }
                  if (filtered.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: _HomeEmptyState(
                        icon: Icons.search_off,
                        title: 'No matches found',
                        message:
                        'Try another title or clear your status filter.',
                        actionLabel: 'Clear filters',
                        onAction: onClearFilters,
                      ),
                    );
                  }

                  final finished = all
                      .where(
                        (drama) =>
                    drama.status == DramaStatus.finished,
                  )
                      .length;

                  return SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16, 4, 16, 0,
                          ),
                          child: CollectionSummary(
                            total: all.length,
                            finished: finished,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: isTablet
                            ? SliverGrid(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 180,
                          ),
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final drama = filtered[index];

                              return DramaCard(
                                drama: drama,
                                onTap: () => onOpen(drama),
                              );
                            },
                            childCount: filtered.length,
                          ),
                        )
                            : SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final drama = filtered[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 12,
                                ),
                                child: DramaCard(
                                  drama: drama,
                                  onTap: () => onOpen(drama),
                                ),
                              );
                            },
                            childCount: filtered.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HomeEmptyState extends StatelessWidget {
  const _HomeEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 64,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  actionLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

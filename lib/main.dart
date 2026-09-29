import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/drama/data/drama_repository.dart';
import 'features/drama/presentation/screens/home_shell.dart';

void main() {
  final repository = DramaRepository();
  runApp(DramaApp(repository: repository));
}

class DramaApp extends StatelessWidget {
  const DramaApp({super.key, required this.repository});

  final DramaRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Drama',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: HomeShell(repository: repository),
    );
  }
}

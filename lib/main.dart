import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/drama/presentation/screens/home_shell.dart';
import 'features/harness/device_harness.dart';

void main() {
  runApp(const DramaApp());
}

class DramaApp extends StatelessWidget {
  const DramaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Drama',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: DeviceHarness(
        childBuilder: (repository) {
          return HomeShell(
            repository: repository,
          );
        },
      ),
    );
  }
}
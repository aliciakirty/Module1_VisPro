import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/types.dart';

import 'mock_shared_preferences_async.dart';
import 'package:kdrama/features/drama/data/drama_repository.dart';
import 'package:kdrama/features/drama/presentation/screens/home_shell.dart';

void main() {
TestWidgetsFlutterBinding.ensureInitialized();

testWidgets(
'HomeShell displays and scrolls through 500 dramas',
(tester) async {
// Prepare the mock platform.
final mockPlatform = MockSharedPreferencesAsyncPlatform();
SharedPreferencesAsyncPlatform.instance = mockPlatform;

// Prepare 500 sample dramas in local storage.
await mockPlatform.setStringList(
'dramas',
List<String>.generate(
500,
(index) => jsonEncode({
'id': '${index + 1}',
'title': 'Drama ${(index + 1).toString().padLeft(3, '0')}',
'genre': ['Drama', 'Romance'],
'year': 2024,
'episodes': 16,
'watchedEpisodes': <int>[],
'status': 'backlog',
'rating': null,
'description': 'Sample drama number ${index + 1}.',
}),
),
const SharedPreferencesOptions(),
);

final repository = DramaRepository();

// Verify that all 500 dramas can be loaded.
final loadedDramas = await repository.getDramas();
expect(loadedDramas.length, 500);
expect(loadedDramas.last.title, 'Drama 500');

await tester.pumpWidget(
MaterialApp(
home: HomeShell(repository: repository),
),
);

await tester.pumpAndSettle();

// Verify the first drama is displayed.
expect(find.text('Drama 001'), findsOneWidget);

// Find the vertical collection scrollable.
final scrollable = find.descendant(
of: find.byType(CustomScrollView).first,
matching: find.byWidgetPredicate(
(widget) =>
widget is Scrollable &&
widget.axisDirection == AxisDirection.down,
),
);

expect(scrollable, findsOneWidget);

// Scroll until the final drama becomes visible.
for (var i = 0; i < 120; i++) {
if (find.text('Drama 500').evaluate().isNotEmpty) {
break;
}

await tester.drag(
scrollable,
const Offset(0, -400),
);
await tester.pumpAndSettle();
}

expect(find.text('Drama 500'), findsOneWidget);
},
);
}
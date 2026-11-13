import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_hub/main.dart';

void main() {
  testWidgets('Complete Movie Hub application end-to-end test', (WidgetTester tester) async {
    // 1. Launch MovieHubApp
    await tester.pumpWidget(const MovieHubApp());

    // Verify SplashScreen initial state
    expect(find.text('🎬'), findsOneWidget);
    expect(find.text('Movie Hub'), findsOneWidget);
    expect(find.text('Your world of movies, all in one place'), findsOneWidget);

    // 2. Auto-transition from Splash to HomeScreen (3 seconds)
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    // Verify HomeScreen elements
    expect(find.text('Welcome to Movie Hub'), findsOneWidget);
    expect(find.text('Browse top movies and explore genres'), findsOneWidget);
    expect(find.widgetWithText(Card, 'Movie List'), findsOneWidget);
    expect(find.widgetWithText(Card, 'About'), findsOneWidget);

    // 3. Navigate to ListScreen via Card
    await tester.tap(find.widgetWithText(Card, 'Movie List'));
    await tester.pumpAndSettle();

    // Verify CustomScrollView and SliverAppBar
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.byType(SliverAppBar), findsOneWidget);
    expect(find.text('Inception (2010) — Sci-Fi'), findsOneWidget);

    // Scroll down to verify 10th movie
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('Jurassic Park (1993) — Adventure'), findsOneWidget);

    // 4. Open Drawer from ListScreen and navigate to AboutScreen
    final ScaffoldState listScaffoldState = tester.firstState(find.byType(Scaffold));
    listScaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'About'));
    await tester.pumpAndSettle();

    // Verify AboutScreen elements
    expect(find.text('About Movie Hub'), findsOneWidget);
    expect(find.text('Action'), findsOneWidget);
    expect(find.text('Comedy'), findsOneWidget);
    expect(find.text('Horror'), findsOneWidget);
    expect(find.text('Romance'), findsOneWidget);

    // Scroll GridView to reveal bottom items
    await tester.drag(find.byType(GridView), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Sci-Fi'), findsOneWidget);
    expect(find.text('Animation'), findsOneWidget);
    expect(find.text('Developed by [Your Name]'), findsOneWidget);

    // 5. Open Drawer from AboutScreen and navigate to HomeScreen
    final ScaffoldState aboutScaffoldState = tester.firstState(find.byType(Scaffold));
    aboutScaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ListTile, 'Home'));
    await tester.pumpAndSettle();

    // Verify return to HomeScreen
    expect(find.text('Welcome to Movie Hub'), findsOneWidget);
  });
}

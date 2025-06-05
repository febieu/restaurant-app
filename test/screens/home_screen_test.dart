import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'package:restaurant_app/screen/home/greetings_widget.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/services/favorite/sqlite_service.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}
class MockSqliteService extends Mock implements SqliteService {}

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

void main() {
  late MockRestaurantListProvider mockRestaurantListProvider;

  final mockSqliteService = MockSqliteService();

  setUp(() {
    mockRestaurantListProvider = MockRestaurantListProvider();
  });

  setUpAll(() => HttpOverrides.global = _MockHttpOverrides());

  Widget createTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        Provider<SqliteService>.value(
          value: mockSqliteService,
        ),
        ChangeNotifierProvider<RestaurantListProvider>.value(
          value: mockRestaurantListProvider,
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<SqliteService>(),
          ),
        ),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('return GreetingsWidget and RestaurantCard when state is loaded', (WidgetTester tester) async {
    final mockRestaurantList = [
      Restaurant(
        id: 'a12',
        name: 'Seventeen Resto',
        description: 'Description',
        pictureId: 'picture',
        city: 'Jakarta',
        rating: 5.0,
      ),
    ];

    when(() => mockRestaurantListProvider.resultState)
    .thenReturn(RestaurantListLoadedState(mockRestaurantList));

    when(() => mockRestaurantListProvider.fetchRestaurantList())
        .thenAnswer((_) async {});

    await tester.pumpWidget(createTestWidget(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(GreetingsWidget), findsOneWidget);
    expect(find.byType(RestaurantCard), findsNWidgets(mockRestaurantList.length));
    }
  );
}

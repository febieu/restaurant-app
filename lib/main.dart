import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/navigation/navigation_provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/navigation/navigation_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/services/sqlite_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          Provider(
            create: (context) => SqliteService(),
          ),
          Provider(
            create: (context) => ApiServices(),
          ),
          ChangeNotifierProvider(
              create: (context) => RestaurantListProvider(
                context.read<ApiServices>(),
              ),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantDetailProvider(
              context.read<ApiServices>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantSearchProvider(
              context.read<ApiServices>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => LocalDatabaseProvider(
              context.read<SqliteService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => NavigationProvider(),
          )
        ],
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const NavigationScreen(),
        NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          id: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
        NavigationRoute.favoriteRoute.name: (context) => const FavoriteScreen(),
      }
    );
  }
}
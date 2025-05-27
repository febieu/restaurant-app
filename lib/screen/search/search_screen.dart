import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  String query = '';
  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      context
        .read<RestaurantSearchProvider>()
        .fetchRestaurantSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestaurantSearchProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                provider.fetchRestaurantSearch(value);
              },
              decoration: InputDecoration(
                hintText: 'Search a Restaurant',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: Colors.orange,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Consumer<RestaurantSearchProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState){
                    RestaurantSearchNoneState() => const Center(
                      child: Text('There is no result'),
                    ),
                    RestaurantSearchLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    RestaurantSearchErrorState() => Center(
                      child: Text('Error show result from Restaurant Search'),
                    ),
                    RestaurantSearchLoadedState(data: var restaurants) => ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: RestaurantCard(
                            restaurant: restaurant,
                            onTap: () {
                              Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant.id,
                              );
                            },
                          ),
                        );
                      }
                    ),
                  };
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

























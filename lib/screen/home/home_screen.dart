import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

import '../../static/navigation_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          RestaurantListLoadedState(data: var restaurantList) => ListView.separated(
              separatorBuilder: (context, index) => const SizedBox.square(dimension: 8),
              itemCount: restaurantList.length + 1,
              itemBuilder: (context, index) {
                if(index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Restaurant",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Recommendation restaurant for you!",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ]
                    ),
                  );
                }

                final restaurant = restaurantList[index - 1];
                return RestaurantCard(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: restaurant.id,
                    );
                  }
                );
              }
          ),
          RestaurantListErrorState(error: var message) => Center(
            child: Text(message),
          ),
            _ => const SizedBox(),
          };
        }
      ),
    );
  }
}
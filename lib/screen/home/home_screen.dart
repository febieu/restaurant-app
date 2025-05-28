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
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/images/ic_launcher.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text(
            'Taste Voyage',
          style: TextStyle(
            color: Colors.deepOrange
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context,
                NavigationRoute.searchRoute.name,
              );
            },
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<RestaurantListProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              RestaurantListLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              RestaurantListLoadedState(data: var restaurantList) => ListView.separated(
                separatorBuilder: (context, index) => const SizedBox.square(dimension: 0),
                itemCount: restaurantList.length + 1,
                itemBuilder: (context, index) {
                  if(index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, Welcome Back!",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Find your perfect restaurant for eat today!",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 12,),
                      ],
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
                    },
                  );
                },
              ),
              RestaurantListErrorState(error: var message) => Center(
                child: Text(message),
              ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
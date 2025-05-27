import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';

class FavoriteIconButtonWidget extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteIconButtonWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDatabaseProvider>(
      builder: (context, provider, child) {
        final isFav = provider.isFavorite(restaurant.id);

        return IconButton(
          onPressed: () {
            provider.toggleFavorite(restaurant);
          },
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border_outlined,
            color: isFav ? Colors.red : Colors.grey,
            size: 20,
          ),
        );
      }
    );
  }
}

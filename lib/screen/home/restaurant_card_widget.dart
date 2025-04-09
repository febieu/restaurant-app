import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCard ({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 80,
                  minHeight: 80,
                  maxWidth: 120,
                  minWidth: 120,
                ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    ApiServices.getImageUrl(restaurant.pictureId),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox.square(dimension: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                        ),
                        const SizedBox.square(dimension: 2),
                        Expanded(
                            child: Text(
                              restaurant.city,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                        ),
                      ],
                    ),
                    const SizedBox.square(dimension: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.orange,
                        ),
                        const SizedBox.square(dimension: 4),
                        Expanded(
                            child: Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                        )
                      ],
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
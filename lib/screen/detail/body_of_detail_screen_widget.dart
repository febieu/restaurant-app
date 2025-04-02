import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  final List<Category> categories;
  final Menu menus;


  const BodyOfDetailScreenWidget ({
    super.key,
    required this.restaurantDetail,
    required this.categories,
    required this.menus,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: restaurantDetail.pictureId,
              child: Image.network(
                ApiServices.getImageUrl(restaurantDetail.pictureId),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.square(dimension: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    child: Text(
                      restaurantDetail.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                ),
                const SizedBox.square(dimension: 4),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.amber,
                    ),
                    Text(
                      restaurantDetail.rating.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox.square(dimension: 4),
            Text(
              ('${restaurantDetail.city}, ${restaurantDetail.address}'),
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox.square(dimension: 8),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          category.name,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox.square(dimension: 12),
            Text(
              "Deskripsi:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              restaurantDetail.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox.square(dimension: 12),
            Text(
              'Menu:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Foods:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox.square(dimension: 4),
            Text(
              menus.checkFoods,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox.square(dimension: 8),
            Text(
              'Drinks:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox.square(dimension: 4),
            Text(
              menus.checkDrinks,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/screen/detail/description_field.dart';
import 'package:restaurant_app/screen/detail/review_section.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  final List<Category> categories;
  final Menu menus;
  final List<CustomerReview> reviews;

  const BodyOfDetailScreenWidget ({
    super.key,
    required this.restaurantDetail,
    required this.categories,
    required this.menus,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Hero(
              tag: restaurantDetail.pictureId,
              child: Image.network(
                ApiServices.getLargeImage(restaurantDetail.pictureId),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 320,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                          restaurantDetail.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                    ),
                    const SizedBox.square(dimension: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.black54
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox.square(dimension: 8),
                Text(
                  "Deskripsi:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                DescriptionText(text: restaurantDetail.description),
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
                const SizedBox.square(dimension: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Review:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) => ReviewSection(restaurantId: restaurantDetail.id,),
                        );
                      },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(28,28)
                        ),
                      child: Text(
                        "Add Review",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.deepOrange
                        ),
                      )
                    ),
                  ],
                ),
                const SizedBox.square(dimension: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    reviews.length,
                    (index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            reviews[index].name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const Spacer(),
                          Text(
                            reviews[index].date,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        reviews[index].review,
                        style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    );
                    }
                  ),
                ),
                const SizedBox.square(dimension: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class Category {
  final String name;

  Category({
    required this.name
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['name']
    );
  }
}

class Menu {
  final List<String> foods;
  final List<String> drinks;

  Menu({
    required this.foods,
    required this.drinks
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: (json['foods'] as List).map((e) => e['name'] as String).toList(),
      drinks: (json['drinks'] as List).map((e) => e['name'] as String).toList(),
    );
  }

  String get checkFoods => foods.isNotEmpty ? foods.join(', ') : 'No food available';

  String get checkDrinks => drinks.isNotEmpty ? drinks.join(', ') : 'No drink available';
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview ({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
        name: json['name'],
        review: json['review'],
        date: json['date'],
    );
  }
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menu menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetail ({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews
  });

  factory RestaurantDetail.fromJson (Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      rating: (json['rating'] as num).toDouble(),
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      menus: Menu.fromJson(json['menus']),
      customerReviews: (json['customerReviews'] as List)
          .map((e) => CustomerReview.fromJson(e))
          .toList(),
    );
  }
}
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class  RestaurantReviewResponse {
  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  RestaurantReviewResponse ({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantReviewResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantReviewResponse(
        error: json['error'],
        message: json['message'],
        customerReviews: (json['customerReviews'] as List)
            .map((e) => CustomerReview.fromJson(e))
            .toList(),
    );
  }
}
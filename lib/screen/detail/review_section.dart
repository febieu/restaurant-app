import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';

class ReviewSection extends StatefulWidget {
  final String restaurantId;

  const ReviewSection({
    super.key,
    required this.restaurantId,
  });

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  bool _isLoading = false;

  void _submitReview() async {
    final name = _nameController.text.trim();
    final comment = _commentController.text.trim();

    if (name.length < 4 || name.length > 15) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name must be between 4 and 15 characters')),
      );
      return;
    }
    if (comment.length > 150) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review must not be more than 150 characters')),
      );
      return;
    }
    if (_nameController.text.isEmpty || _commentController.text.isEmpty) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    try {
      final restaurantProvider = Provider.of<RestaurantDetailProvider>(context, listen: false);
      await restaurantProvider.postReview(
        widget.restaurantId,
        _nameController.text,
        _commentController.text,
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thank you! Your review has been submitted :)'),)
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Oops! Failed to submit your review. Please try again ;)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _commentController,
            decoration: InputDecoration(labelText: 'Review'),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          _isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
            onPressed: _submitReview,
            child: Text('Submit'),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(
      this._apiServices,
      );

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();
  bool _isLoading = false;

  RestaurantDetailResultState get resultState => _resultState;
  bool get isLoading => _isLoading;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);
      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on SocketException {
      _resultState = RestaurantDetailErrorState('Please check your connection.');
      notifyListeners();
    }
    on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
  Future<void> postReview(String id, String name, String review) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiServices.postReview(id, name, review);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
      } else {
        await fetchRestaurantDetail(id);
      }
    } on SocketException {
      _resultState = RestaurantDetailErrorState('Please check your connection.');
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState('Failed to post a review: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> postReview(String id, String name, String review) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     await _apiServices.postReview(id, name, review);
  //     await fetchRestaurantDetail(id);
  //   } on SocketException {
  //     _resultState = RestaurantDetailErrorState('Please check your connection.');
  //   } catch (e) {
  //     throw Exception('Failed to post a review');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  //  }



}
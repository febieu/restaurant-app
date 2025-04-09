import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(
      this._apiServices,
  );

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();
  bool _isLoading = false;

  RestaurantSearchResultState get resultState => _resultState;
  bool get isLoading => _isLoading;

  Future<void> fetchRestaurantSearch (String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getSearchRestaurant(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState("Error fetch Search Restaurant");
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on SocketException {
      _resultState = RestaurantSearchErrorState('Please check your connection.');
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchRestaurant() async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();
      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantSearchErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on SocketException {
      _resultState = RestaurantSearchErrorState('Please check your connection.');
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/services/favorite/sqlite_service.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final SqliteService _service;

  LocalDatabaseProvider(this._service) {
    loadAllRestaurantValue();
  }

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Set<String> _favoriteList = {};
  Set<String> get favoriteList => _favoriteList;

  bool isFavorite(String id) => _favoriteList.contains(id);

  Future<void> saveRestaurantValue (Restaurant value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;
      if (isError) {
        _message = "Failed to save your data";
        notifyListeners();
      } else {
        _message = "Your data is saved";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to save your data";
      notifyListeners();
    }
  }

  Future<void> loadAllRestaurantValue() async {
    try {
      _restaurantList = await _service.getAllItems();
      _favoriteList = _restaurantList!
        .map((restaurant) => restaurant.id)
        .toSet();
      _message = "All of your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your all data";
      notifyListeners();
    }
  }

  Future<void> loadRestaurantValueById (int id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Your data is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your data";
      notifyListeners();
    }
  }

  Future<void> updateRestaurantValueById (int id, Restaurant value) async {
    try {
      final result = await _service.updateItem(id, value);
      final isRestaurantValueUpdated = result == 0;

      if (isRestaurantValueUpdated) {
        _message = "Failed to update your data";
        notifyListeners();
      } else {
        _message = "Your data is updated";
        notifyListeners();
      }
    } catch (e) {
      _message = "Failed to update your data";
      notifyListeners();
    }
  }

  Future<void> removeRestaurantValueById (String id) async {
    try {
      await _service.removeItem(id);

      _message = "Your data is removed";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your data";
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Restaurant value) async {
    if(isFavorite(value.id)) {
      _favoriteList.remove(value.id);
      await removeRestaurantValueById(value.id);
      notifyListeners();
    } else {
      _favoriteList.add(value.id);
      await saveRestaurantValue(value);
      notifyListeners();
    }
    await loadAllRestaurantValue();
    notifyListeners();
  }
}

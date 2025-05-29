import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class MockApiService extends Mock implements ApiServices {}

void main() {
  late RestaurantListProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  test('return RestaurantListNoneState as the initial state', () {
    expect(provider.resultState, isA<RestaurantListNoneState>());
  });

  test('returns restaurant list when API call is successful', () async {
    final mockRestaurantList = [
      Restaurant(
          id: 'a12',
          name: 'Seventeen Resto',
          description: 'Description',
          pictureId: 'picture',
          city: 'Jakarta',
          rating: 5.0,
      ),
    ];
    final mockResult = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 1,
        restaurants: mockRestaurantList,
    );

    when(() => mockApiService.getRestaurantList())
        .thenAnswer((_) async => mockResult);

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListLoadedState>());

    final state = provider.resultState as RestaurantListLoadedState;

    expect(state.data, isNotEmpty);
    expect(state.data.first.name, equals('Seventeen Resto'));
  });

  test('returns error when API call fails', () async {
    final mockResult = RestaurantListResponse(
      error: true,
      message: "Failed to load data",
      count: 0,
      restaurants: [],
    );

    when(() => mockApiService.getRestaurantList())
        .thenAnswer((_) async => mockResult);

    await provider.fetchRestaurantList();

    expect(provider.resultState, isA<RestaurantListErrorState>());

    final errorState = provider.resultState as RestaurantListErrorState;

    expect(errorState.error, contains('Failed'));
  });
}
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]);

  void addFavorite(int item) {
    state = [...state, item];
  }

  void removeFavorite(int item) {
    state = state.where((element) => element != item).toList();
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});

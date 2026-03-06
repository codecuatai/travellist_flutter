import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _kFavoritesKey = 'favorites_ids';
  final Set<String> _favorites = {};

  Set<String> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kFavoritesKey) ?? [];
    _favorites.clear();
    _favorites.addAll(list);
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kFavoritesKey, _favorites.toList());
  }

  bool isFavorite(String id) => _favorites.contains(id);
}

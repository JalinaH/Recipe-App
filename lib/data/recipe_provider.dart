import 'package:assignment_two/data/recipe_api.dart';
import 'package:flutter/foundation.dart';
import 'recipe_model.dart';

class RecipesProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  final List<Recipe> _favoriteRecipes = [];
  bool _isLoading = false;
  String _error = '';

  List<Recipe> get recipes => _recipes;
  List<Recipe> get favoriteRecipes => _favoriteRecipes;
  bool get isLoading => _isLoading;
  String get error => _error;

  final RecipeService _recipeService = RecipeService();

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _recipes = await _recipeService.fetchRecipes();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(Recipe recipe) {
    recipe.isFavorite = !recipe.isFavorite;

    if (recipe.isFavorite) {
      _favoriteRecipes.add(recipe);
    } else {
      _favoriteRecipes.removeWhere((r) => r.id == recipe.id);
    }

    notifyListeners();
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recipe_model.dart';

class RecipeService {
  static const String baseUrl = 'https://dummyjson.com/recipes';

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> recipesJson = data['recipes'] ?? [];

        return recipesJson.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }
}

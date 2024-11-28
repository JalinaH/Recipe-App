class Recipe {
  final int id;
  final String name;
  final String cuisine;
  final String image;
  final double rating;
  final int reviewCount;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTime;
  final int cookTime;
  final String difficulty;
  final int servings;
  final int calories;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.difficulty,
    required this.servings,
    required this.calories,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
      image: json['image'],
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      prepTime: json['prepTime'] ?? 0,
      cookTime: json['cookTime'] ?? 0,
      difficulty: json['difficulty'] ?? 'Unknown',
      servings: json['servings'] ?? 0,
      calories: json['calories'] ?? 0,
    );
  }
}

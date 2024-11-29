import 'package:assignment_two/data/recipe_model.dart';
import 'package:assignment_two/data/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';


class RecipeDetailsScreen extends StatelessWidget {
  final int recipeId;
  final Recipe? recipe;

  const RecipeDetailsScreen({
    super.key,
    required this.recipeId,
    this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context);
    final displayRecipe =
        recipe ?? recipesProvider.recipes.firstWhere((r) => r.id == recipeId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                displayRecipe.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: displayRecipe.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // Gradient overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  displayRecipe.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: displayRecipe.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  recipesProvider.toggleFavorite(displayRecipe);
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Recipe Details Section
                _buildRecipeInfoRow(displayRecipe),

                const SizedBox(height: 16),

                // Ingredients Section
                _buildSectionTitle('Ingredients'),
                ...displayRecipe.ingredients
                    .map((ingredient) => _buildIngredientItem(ingredient)),

                const SizedBox(height: 16),

                // Instructions Section
                _buildSectionTitle('Instructions'),
                ...displayRecipe.instructions.asMap().entries.map((entry) =>
                    _buildInstructionStep(entry.key + 1, entry.value)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeInfoRow(Recipe recipe) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoChip(Icons.timer, '${recipe.prepTime} min', 'Prep'),
        _buildInfoChip(Icons.kitchen, '${recipe.cookTime} min', 'Cook'),
        _buildInfoChip(Icons.people, '${recipe.servings}', 'Serves'),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.deepOrange),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIngredientItem(String ingredient) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.circle,
            size: 8,
            color: Colors.deepOrange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              ingredient,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(int step, String instruction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                '$step',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

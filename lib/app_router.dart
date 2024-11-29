import 'package:assignment_two/data/recipe_model.dart';
import 'package:assignment_two/data/recipe_provider.dart';
import 'package:assignment_two/presentation/favourites/favourites_screen.dart';
import 'package:assignment_two/presentation/home/home_screen.dart';
import 'package:assignment_two/presentation/recipe%20details/recipe_details.dart';
import 'package:assignment_two/presentation/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'recipe/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              final recipe = (state.extra as Recipe?);
              return RecipeDetailsScreen(recipeId: id, recipe: recipe);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
    ],
  );
}

class RecipeViewerApp extends StatelessWidget {
  const RecipeViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipesProvider(),
      child: MaterialApp.router(
        title: 'Recipe Viewer',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}

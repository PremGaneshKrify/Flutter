import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saverecipe/models/recipe_model.dart';
import 'package:saverecipe/provider/app_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int appBarColor;
  final int categoryIndex;
  final int recipeIndex;

  const RecipeDetailScreen({
    required this.appBarColor,
    required this.categoryIndex,
    required this.recipeIndex,
  });

  @override
  Widget build(BuildContext context) {
    RecipeModel recipe = context.select(
      (AppProvider value) =>
          value.categories[categoryIndex].recipes[recipeIndex],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Color(appBarColor ?? 0xFF123456),
        actions: [
          IconButton(
            icon: recipe.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () {
              context
                  .read<AppProvider>()
                  .toggleFavorite(categoryIndex, recipeIndex);
            },
          )
        ],
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Image.memory(recipe.image),
      ),
    );
  }
}

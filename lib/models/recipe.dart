import 'package:food_recipe_app/models/review.dart';
import 'package:food_recipe_app/models/steps.dart';

import 'ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String chefID;
  final String plateImageURL;
  final String actualImageURL;
  final List<Ingredient> ingredients;
  final List<Step> steps;
  final List<Review> reviews;
  final double averageRate;
  final double prepareTime;
  final String country;

  Recipe({
    required this.country,
    required this.plateImageURL,
    required this.actualImageURL,
    required this.id,
    required this.name,
    required this.chefID,
    required this.ingredients,
    required this.steps,
    required this.reviews,
    required this.averageRate,
    required this.prepareTime,
  });
}

import 'package:food_recipe_app/models/review.dart';
import 'package:food_recipe_app/models/steps.dart';

import 'ingredient.dart';

class Recipe {
  final String id;
  String name;
  String description;
  final String chefID;
  String? plateImageURL;
  String? actualImageURL;
  final List<Ingredient> ingredients;
  final List<Steps> steps;
  List<Review?>? reviews;
  final double prepareTime;
  final String country;

  Recipe({
    required this.description,
    required this.country,
    this.plateImageURL = "",
    this.actualImageURL = "",
    required this.id,
    required this.name,
    required this.chefID,
    required this.ingredients,
    required this.steps,
    this.reviews = const [],
    required this.prepareTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'chefID': chefID,
      'plateImageURL': plateImageURL,
      'actualImageURL': actualImageURL,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toMap()).toList(),
      'steps': steps.map((step) => step.toMap()).toList(),
      'reviews': reviews?.map((review) => review?.toMap()).toList(),
      'prepareTime': prepareTime,
      'country': country,
    };
  }

  static Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      chefID: map['chefID'],
      plateImageURL: map['plateImageURL'],
      actualImageURL: map['actualImageURL'],
      ingredients: List<Ingredient>.from(map['ingredients']
          .map((ingredientMap) => Ingredient.fromMap(ingredientMap))),
      steps: List<Steps>.from(
          map['steps'].map((stepMap) => Steps.fromMap(stepMap))),
      reviews: map['reviews'] != null
          ? List<Review>.from(
              map['reviews'].map((reviewMap) => Review.fromMap(reviewMap)))
          : [],
      prepareTime: map['prepareTime'],
      country: map['country'],
    );
  }
}

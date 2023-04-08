import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/models/recipe.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';

abstract class MainMenuState {}

class MainMenuInitial extends MainMenuState {}

class MainMenuRecipesUpdated extends MainMenuState {}

class MainMenuCubit extends Cubit<MainMenuState> {
  MainMenuCubit() : super(MainMenuInitial());
  List<Recipe> recipes = [];

  void getRecipes() async {
    FirestoreService.instance.getCollectionStream("foods").listen((event) {
      recipes = event.docs
          .map((e) => Recipe.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      this.recipes = recipes;
      print(recipes);
      emit(MainMenuRecipesUpdated());
    });
  }
}

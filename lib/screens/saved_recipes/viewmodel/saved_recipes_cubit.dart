import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/models/recipe.dart';
import 'package:food_recipe_app/screens/service/auth_service.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';

abstract class SavedRecipesState {}

class SavedRecipesInitial extends SavedRecipesState {}

class SavedRecipesUpdated extends SavedRecipesState {}

class SavedRecipesCubit extends Cubit<SavedRecipesState> {
  SavedRecipesCubit() : super(SavedRecipesInitial());
  List<Recipe> recipes = [];

  void getRecipes() async {
    FirestoreService.instance.getCollectionStream("foods").listen((event) {
      recipes = event.docs
          .map((e) => Recipe.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      if (AuthService.instance.loggedInUser == null) return;
      recipes = recipes
          .where((element) => AuthService.instance.loggedInUser!.savedRecipes
              .contains(element.id))
          .toList();
      this.recipes = recipes;

      emit(SavedRecipesUpdated());
    });
  }
}

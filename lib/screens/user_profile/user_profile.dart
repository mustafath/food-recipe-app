import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/recipe.dart';
import '../../models/user.dart';
import '../service/auth_service.dart';
import '../service/firestore_service.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  UserBaseModel? userBaseModel;

  List<Recipe> recipes = [];

  void getRecipes(List<String> recipeIds) async {
    userBaseModel = await AuthService.instance.loggedInUser;

    for (var id in recipeIds) {
      print(id);
      Recipe? recipe = await getRecipeById(id);
      print(recipe?.name);
      if (recipe != null) {
        print(recipe);
        recipes.add(recipe);
      }

      emit(UserProfileUpdated());
    }
  }

  Future<Recipe?> getRecipeById(String id) async {
    Recipe? returnedRecipe = null;
    await FirestoreService.instance.getDocument("foods", id).then((value) {
      returnedRecipe = Recipe.fromMap(value.data() as Map<String, dynamic>);
      print(returnedRecipe);
    });
    return returnedRecipe;
  }
}

class UserProfileUpdated extends UserProfileState {}

class UserProfileInitial extends UserProfileState {}

abstract class UserProfileState {}

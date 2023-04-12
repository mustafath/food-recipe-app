// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_recipe_app/models/recipe.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';

abstract class MainMenuState {}

class MainMenuInitial extends MainMenuState {}

class MainMenuRecipesUpdated extends MainMenuState {}

class IndexChangedState extends MainMenuState {}

class MainMenuCubit extends Cubit<MainMenuState> {
  TextEditingController searchController = TextEditingController();
  PageController pageController = PageController();

  int currentIndex = 0;
  List<Recipe> allRecipes = [];
  List<Recipe> recipes = [];
  List<Recipe> recentRecipes = [];
  MainMenuCubit() : super(MainMenuInitial()) {
    searchController.addListener(_onSearchTextChanged);
  }

  void changeIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(IndexChangedState());
  }

  void _onSearchTextChanged() {
    if (searchController.text.isEmpty) {
      recipes = allRecipes;
    } else {
      this.recipes = allRecipes
          .where((element) => element.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    emit(MainMenuRecipesUpdated());
  }

  void getRecipes() async {
    FirestoreService.instance.getCollectionStream("foods").listen((event) {
      allRecipes = event.docs
          .map((e) => Recipe.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      this.recipes = allRecipes;
      recipes.forEach((element) {
        print(element.id);
      });
      emit(MainMenuRecipesUpdated());
    });
  }
}

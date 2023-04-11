// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/screens/service/auth_service.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';
import 'package:food_recipe_app/screens/service/storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../models/ingredient.dart';
import '../../../models/recipe.dart';
import '../../../models/steps.dart';

abstract class AddRecipeState {}

class AddRecipeInitial extends AddRecipeState {}

class AddRecipeImageChanged extends AddRecipeState {}

class AddRecipeLoading extends AddRecipeState {
  AddRecipeLoading(this.isLoading);

  final bool isLoading;
}

class AddRecipeCubit extends Cubit<AddRecipeState> {
  String _collection = "foods";

  AddRecipeCubit({
    required this.foodNameController,
    required this.foodDescriptionController,
    required this.countryController,
    required this.prepareTimeController,
    required this.stepControllers,
    required this.nameControllers,
    required this.quantityControllers,
  }) : super(AddRecipeInitial());

  final TextEditingController foodNameController;
  final TextEditingController foodDescriptionController;
  final TextEditingController countryController;
  final TextEditingController prepareTimeController;
  final List<TextEditingController> stepControllers;
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> quantityControllers;

  final ImagePicker _picker = ImagePicker();
  File? plateImage = null;
  File? actualImage = null;

  Future<void> pickFoodPlateImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      plateImage = File(pickedFile.path);
      emit(AddRecipeImageChanged());
    }
  }

  Future<void> pickFoodActualImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      actualImage = File(pickedFile.path);
      emit(AddRecipeImageChanged());
    }
  }

  List<Ingredient> prepareIngredients() {
    List<Ingredient> ingredients = [];
    for (int i = 0; i < nameControllers.length; i++) {
      ingredients.add(Ingredient(
        name: nameControllers[i].text,
        quantity: int.parse(quantityControllers[i].text),
        id: '',
      ));
    }
    return ingredients;
  }

  List<Steps> prepareSteps() {
    List<Steps> steps = [];
    for (int i = 0; i < stepControllers.length; i++) {
      steps.add(Steps(
        stepDescription: stepControllers[i].text,
        stepNo: i,
      ));
    }

    return steps;
  }

  Recipe prepareRecipe() {
    List<Ingredient> ingredients = prepareIngredients();
    List<Steps> steps = prepareSteps();

    Recipe recipe = Recipe(
      chefID: FirebaseAuth.instance.currentUser?.uid ?? "",
      name: foodNameController.text,
      description: foodDescriptionController.text,
      country: countryController.text,
      id: Uuid().v4().toString(),
      ingredients: ingredients,
      steps: steps,
      prepareTime: double.parse(prepareTimeController.text),
    );

    return recipe;
  }

  Future<void> addRecipe() async {
    emit(AddRecipeLoading(true));
    Recipe recipe = prepareRecipe();
    print(recipe);

    String plateImageURL = await StorageService.instance
        .uploadFile(plateImage!.path, recipe.id, ImageType.plate);
    String actualImageURL = await StorageService.instance
        .uploadFile(actualImage!.path, recipe.id, ImageType.actual);

    recipe.plateImageURL = plateImageURL;
    recipe.actualImageURL = actualImageURL;

    await FirestoreService.instance
        .setData(_collection, recipe.id, recipe.toMap());
    AuthService.instance.loggedInUser!.recipes!.add(recipe.id);

    await FirestoreService.instance.updateData(
        collection: "users",
        documentId: AuthService.instance.loggedInUser!.id,
        data: {
          "recipes": AuthService.instance.loggedInUser!.recipes,
        });

    // TODO: Kullanıcılara bildirim gönderilecek.
    // TODO: Local bildirim gönderilecek.

    emit(AddRecipeLoading(false));
  }
}

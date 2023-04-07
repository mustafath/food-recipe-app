// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddRecipeState {}

class AddRecipeInitial extends AddRecipeState {}

class AddRecipeImageChanged extends AddRecipeState {}

class AddRecipeCubit extends Cubit<AddRecipeState> {
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
}

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddRecipeState {}

class AddRecipeInitial extends AddRecipeState {}

class AddRecipeImageChanged extends AddRecipeState {}

class AddRecipeCubit extends Cubit<AddRecipeState> {
  AddRecipeCubit() : super(AddRecipeInitial());

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

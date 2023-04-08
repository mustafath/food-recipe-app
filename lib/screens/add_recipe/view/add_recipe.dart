import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/Extensions/Widget.dart';
import 'package:food_recipe_app/componenets/big_button.dart';
import 'package:food_recipe_app/screens/add_recipe/utils/add_recipe_constants.dart.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Extensions/Colors.dart';
import '../../../componenets/app_text_field.dart';
import '../../../extensions/text_style.dart';
import '../cubit/add_recipe_cubit.dart';

class AddRecipe extends StatelessWidget {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController foodDescriptionController =
      TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController prepareTimeController = TextEditingController();
  final List<TextEditingController> stepControllers = [];
  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> quantityControllers = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddRecipeCubit(
        foodNameController: foodNameController,
        foodDescriptionController: foodDescriptionController,
        countryController: countryController,
        prepareTimeController: prepareTimeController,
        stepControllers: stepControllers,
        nameControllers: nameControllers,
        quantityControllers: quantityControllers,
      ),
      child: RecipeScaffold(
        foodNameController: foodNameController,
        foodDescriptionController: foodDescriptionController,
        countryController: countryController,
        prepareTimeController: prepareTimeController,
        stepControllers: stepControllers,
        nameControllers: nameControllers,
        quantityControllers: quantityControllers,
      ),
    );
  }
}

class RecipeScaffold extends StatelessWidget {
  RecipeScaffold({
    Key? key,
    required this.foodNameController,
    required this.foodDescriptionController,
    required this.countryController,
    required this.prepareTimeController,
    required this.stepControllers,
    required this.nameControllers,
    required this.quantityControllers,
  }) : super(key: key);

  final TextEditingController foodNameController;
  final TextEditingController foodDescriptionController;
  final TextEditingController countryController;
  final TextEditingController prepareTimeController;
  final List<TextEditingController> stepControllers;

  final List<TextEditingController> nameControllers;
  final List<TextEditingController> quantityControllers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          height: double.infinity,
          color: AppColors.backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                _buildSubtitle(),
                _buildFoodNameLabel(),
                _buildFoodNameTextField(),
                _buildFoodDescriptionLabel(),
                _buildFoodDescriptionTextField(),
                _buildImageSelectionRow(context),
                _country(),
                _prepareTime(),
                IngredientWidget(
                  nameControllers: nameControllers,
                  quantityControllers: quantityControllers,
                ),
                StepWidget(
                  stepControllers: stepControllers,
                ),
                context.read<AddRecipeCubit>().state is AddRecipeLoading
                    ? (context.read<AddRecipeCubit>().state as AddRecipeLoading)
                            .isLoading
                        ? Container(
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.accentColor,
                              ).paddingTop(20),
                            ))
                        : _addRecipeButton(context).paddingTop(20)
                    : _addRecipeButton(context).paddingTop(20),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BigButton _addRecipeButton(BuildContext context) {
    return BigButton(
        onPressed: () {
          context.read<AddRecipeCubit>().addRecipe();
        },
        buttonText: Constants.addRecipe);
  }

  Widget _prepareTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Constants.preparationTime,
          style: AppTextStyles.smallTextRegular,
        ),
        AppTextField(
          hintText: "... mins",
          controller: prepareTimeController,
          keyboardType: TextInputType.number,
        ).paddingTop(10),
      ],
    ).paddingTop(20);
  }

  Widget _country() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.country,
          style: AppTextStyles.smallTextRegular,
        ),
        AppTextField(
                hintText: "Indian, Italian etc.", controller: countryController)
            .paddingTop(10),
      ],
    ).paddingTop(20);
  }

  Widget _buildTitle() {
    return Text(
      Constants.addRecipe,
      style: AppTextStyles.largeTextBold.copyWith(color: AppColors.blackColor),
    ).paddingTop(60);
  }

  Widget _buildSubtitle() {
    return Text(
      Constants.letThemThankYou,
      style:
          AppTextStyles.smallTextRegular.copyWith(color: AppColors.blackColor),
    ).paddingTop(10);
  }

  Widget _buildFoodNameLabel() {
    return Text(
      Constants.foodName,
      style:
          AppTextStyles.smallTextRegular.copyWith(color: AppColors.blackColor),
    ).paddingTop(30);
  }

  Widget _buildFoodNameTextField() {
    return AppTextField(
      controller: foodNameController,
      hintText: Constants.enterFoodName,
    ).paddingTop(10);
  }

  Widget _buildFoodDescriptionLabel() {
    return Text(
      Constants.foodDescription,
      style:
          AppTextStyles.smallTextRegular.copyWith(color: AppColors.blackColor),
    ).paddingTop(30);
  }

  Widget _buildFoodDescriptionTextField() {
    return AppTextField(
      controller: foodDescriptionController,
      hintText: Constants.enterFoodDescription,
    ).paddingTop(10);
  }

  Widget _buildImageSelectionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFoodPlateImageWidget(context),
        _buildFoodActualImageWidget(context),
      ],
    ).paddingTop(30);
  }

  Widget _buildFoodPlateImageWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: AppColors.neutralGray,
        padding: EdgeInsets.all(10),
        width: 140,
        height: 130 * 1.6,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            Constants.foodPlateImage,
            style: AppTextStyles.mediumTextBold,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (context.read<AddRecipeCubit>().plateImage == null) {
                context.read<AddRecipeCubit>().pickFoodPlateImage();
              }
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor, shape: BoxShape.circle),
              child: context.watch<AddRecipeCubit>().plateImage != null
                  ? CircleAvatar(
                      backgroundColor: AppColors.neutralGray,
                      backgroundImage: FileImage(
                        context.read<AddRecipeCubit>().plateImage!,
                      ),
                    )
                  : const Icon(Icons.add_a_photo_outlined,
                      color: AppColors.secondaryTextColor, size: 50),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildFoodActualImageWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(10),
        color: AppColors.neutralGray,
        width: 210,
        height: 130 * 1.6,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            Constants.foodActualImage,
            style: AppTextStyles.mediumTextBold,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (context.read<AddRecipeCubit>().actualImage == null) {
                context.read<AddRecipeCubit>().pickFoodActualImage();
              }
            },
            child: context.watch<AddRecipeCubit>().actualImage != null
                ? Image.file(
                    context.read<AddRecipeCubit>().actualImage!,
                    width: 180,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.add_a_photo_outlined,
                    color: AppColors.whiteColor, size: 50),
          ),
        ]),
      ),
    );
  }
}

class StepWidget extends StatefulWidget {
  final List<TextEditingController> stepControllers;

  StepWidget({required this.stepControllers});

  @override
  _StepWidgetState createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {
  int stepCounter = 0;
  List<Widget> steps = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add/Remove Step'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      stepCounter++;
                      TextEditingController newController =
                          TextEditingController();
                      widget.stepControllers.add(newController);
                      steps.add(_buildStep(stepCounter, newController));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (stepCounter > 0) {
                        steps.removeLast();
                        widget.stepControllers.removeLast();
                        stepCounter--;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Column(
          children: List.generate(
            stepCounter,
            (index) => _buildStep(index + 1, widget.stepControllers[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildStep(int stepNumber, TextEditingController stepController) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 30,
              width: double.infinity,
              color: AppColors.accentColor,
              child: Text(
                'Step $stepNumber',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // AppTextField(hintText: "Step $stepNumber", controller: )

          Container(
            child: TextField(
              controller: stepController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.secondaryTextColor,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(0)),
                hintText: 'Step $stepNumber',
              ),
              maxLength: 95,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientWidget extends StatefulWidget {
  final List<TextEditingController> nameControllers;
  final List<TextEditingController> quantityControllers;

  IngredientWidget(
      {required this.nameControllers, required this.quantityControllers});

  @override
  _IngredientWidgetState createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  int ingredientCounter = 0;
  List<Widget> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add/Remove Ingredient'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      ingredientCounter++;
                      TextEditingController newNameController =
                          TextEditingController();
                      TextEditingController newQuantityController =
                          TextEditingController();
                      widget.nameControllers.add(newNameController);
                      widget.quantityControllers.add(newQuantityController);
                      ingredients.add(_buildIngredient(ingredientCounter,
                          newNameController, newQuantityController));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (ingredientCounter > 0) {
                        ingredients.removeLast();
                        widget.nameControllers.removeLast();
                        widget.quantityControllers.removeLast();
                        ingredientCounter--;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Column(
          children: List.generate(
            ingredientCounter,
            (index) => _buildIngredient(
                index + 1,
                widget.nameControllers[index],
                widget.quantityControllers[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredient(
      int ingredientNumber,
      TextEditingController nameController,
      TextEditingController quantityController) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    counterText: "",
                    fillColor: AppColors.secondaryTextColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(0)),
                    hintText: 'Ingredient $ingredientNumber',
                  ),
                  maxLength: 50,
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: 100,
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.secondaryTextColor,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(0)),
                    hintText: 'Grams',
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

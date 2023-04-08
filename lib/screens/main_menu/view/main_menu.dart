import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/componenets/app_text_field.dart';
import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/extensions/text_style.dart';
import 'package:food_recipe_app/screens/main_menu/view/new_recipes_plate_view.dart';
import 'package:food_recipe_app/screens/main_menu/view/plate_view.dart';
import 'package:food_recipe_app/screens/main_menu/viewmodel/main_menu_cubit.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';

import '../utils/main_menu_constants.dart';

class MainMenu extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainMenuCubit()..getRecipes(),
      child: BlocConsumer<MainMenuCubit, MainMenuState>(
        listener: (context, state) {},
        builder: (context, state) {
          return buildScaffold(context);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Container(
        padding: EdgeInsets.only(left: 30),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.backgroundColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          welcomeHeader().paddingTop(64),
          AppTextField(
                  hintText: Constants.searchRecipe,
                  controller: searchController)
              .paddingTop(30),
          SizedBox(
            height: 100,
          ),
          Container(
            height: 260,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: context.watch<MainMenuCubit>().recipes.length,
                itemBuilder: (context, item) {
                  return PlateView(
                      recipe: context.watch<MainMenuCubit>().recipes[item]);
                }),
          ),
          Text(Constants.newRecipes,
                  style: AppTextStyles.normalTextBold
                      .copyWith(color: AppColors.blackColor))
              .paddingTop(20),
          Container(
            height: 127,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: context.watch<MainMenuCubit>().recipes.length,
                itemBuilder: (context, item) {
                  return NewRecipesPlate(
                    recipe: context.watch<MainMenuCubit>().recipes[item],
                  );
                }),
          ).paddingTop(5)
        ]),
      )),
    );
  }

  Column welcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.hiFreind,
          style: AppTextStyles.largeTextBold,
        ),
        Text(Constants.whatAreYouCookingToday,
                style: AppTextStyles.smallerTextRegular
                    .copyWith(color: AppColors.secondaryTextColor))
            .paddingTop(5),
      ],
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe_app/componenets/app_text_field.dart';
import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/extensions/text_style.dart';
import 'package:food_recipe_app/screens/add_recipe/view/add_recipe.dart';
import 'package:food_recipe_app/screens/main_menu/view/new_recipes_plate_view.dart';
import 'package:food_recipe_app/screens/main_menu/view/plate_view.dart';
import 'package:food_recipe_app/screens/main_menu/viewmodel/main_menu_cubit.dart';
import 'package:food_recipe_app/screens/saved_recipes/view/saved_recipes.dart';
import 'package:food_recipe_app/screens/search_recipe/view/search_menu.dart';
import 'package:food_recipe_app/screens/service/auth_service.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';

import '../../notifications/notifications_view.dart';
import '../../user_profile/user_profile_screen.dart';
import '../utils/main_menu_constants.dart';

class MainMenu extends StatelessWidget {
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
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBar(),
      resizeToAvoidBottomInset: false,
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: context.watch<MainMenuCubit>().pageController,
          children: [
            buildMainMenu(context),
            SavedRecipes(),
            NotificationsView(),
            UserProfile(),
          ]),
    );
  }

  Center buildMainMenu(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.only(left: 30),
      width: double.infinity,
      height: double.infinity,
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          welcomeHeader().paddingTop(64),
          Padding(
              padding: const EdgeInsets.only(right: 30, top: 30),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchRecipe(),
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: AppColors.neutralGray, size: 16),
                        Container(
                          height: 20,
                          child: Text("Search Recipe",
                              style: AppTextStyles.smallerTextRegular
                                  .copyWith(color: AppColors.neutralGray)),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                            width: 2,
                            color: AppColors.neutralGray.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)),
                  ))),
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
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(100, 0),
                  blurRadius: 100,
                  spreadRadius: 20,
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1))
            ]),
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: context.watch<MainMenuCubit>().recipes.length,
                itemBuilder: (context, item) {
                  return NewRecipesPlate(
                    recipe: context.watch<MainMenuCubit>().recipes[item],
                  );
                }),
          ).paddingTop(5),
          SizedBox(
            height: 100,
          )
        ]),
      ),
    ));
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

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainMenuCubit, MainMenuState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    context.read<MainMenuCubit>().changeIndex(0);
                  },
                  child: context.watch<MainMenuCubit>().currentIndex == 0
                      ? SvgPicture.asset(
                          "lib/assets/home_filled.svg",
                        )
                      : SvgPicture.asset(
                          "lib/assets/home.svg",
                        ),
                ),
                InkWell(
                  onTap: () {
                    context.read<MainMenuCubit>().changeIndex(1);
                  },
                  child: context.watch<MainMenuCubit>().currentIndex == 1
                      ? SvgPicture.asset(
                          "lib/assets/bookmark_filled.svg",
                        )
                      : SvgPicture.asset(
                          "lib/assets/bookmark.svg",
                        ),
                ),
                SizedBox(width: 48.0),
                InkWell(
                  onTap: () {
                    context.read<MainMenuCubit>().changeIndex(2);
                    print(context.read<MainMenuCubit>().currentIndex);
                  },
                  child: context.watch<MainMenuCubit>().currentIndex == 2
                      ? SvgPicture.asset(
                          "lib/assets/bell_filled.svg",
                        )
                      : SvgPicture.asset(
                          "lib/assets/bell.svg",
                        ),
                ),
                InkWell(
                  onTap: () {
                    context.read<MainMenuCubit>().changeIndex(3);
                  },
                  child: context.watch<MainMenuCubit>().currentIndex == 3
                      ? SvgPicture.asset(
                          "lib/assets/profile_filled.svg",
                        )
                      : SvgPicture.asset(
                          "lib/assets/profile.svg",
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddRecipe()));
      },
      child: Icon(Icons.add),
      backgroundColor: AppColors.accentColor,
    );
  }
}

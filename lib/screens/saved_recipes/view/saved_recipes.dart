// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/screens/recipe_detail/view/recipe_detail.dart';
import 'package:kartal/kartal.dart';

import 'package:food_recipe_app/screens/main_menu/view/main_menu.dart';
import 'package:food_recipe_app/utils/utils.dart';

import '../../../componenets/app_text_field.dart';
import '../../../models/recipe.dart';
import '../../main_menu/viewmodel/main_menu_cubit.dart';
import '../viewmodel/saved_recipes_cubit.dart';

class SavedRecipes extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavedRecipesCubit()..getRecipes(),
      child: BlocConsumer<SavedRecipesCubit, SavedRecipesState>(
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: Colors.black,
        title: Text(
          'Saved Recipes',
          style: AppTextStyles.headerTextBold,
        ),
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: AppColors.backgroundColor,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<SavedRecipesCubit>().recipes.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SavedCard(
                        recipe:
                            context.watch<SavedRecipesCubit>().recipes[index],
                      ));
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class SavedCard extends StatelessWidget {
  Recipe recipe;

  SavedCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetail(
                  recipe: recipe,
                )));
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(recipe.actualImageURL ?? ""),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  Align(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFFFE1B3),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 8,
                            color: Color(0xFFFFAD30),
                          ),
                          SizedBox(width: 3),
                          Text(
                            "13",
                            style: textTheme.caption
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomLeft,
                height: 102,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(recipe.name,
                              style: AppTextStyles.smallTextBold
                                  .copyWith(color: Colors.white))),
                    ),
                    SizedBox(height: 3),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "By Mustafa Girgin",
                              style: AppTextStyles.smallerTextSmallLabel
                                  .copyWith(color: Colors.white),
                            ),
                            Spacer(),
                            Container(
                              height: 14,
                              alignment: Alignment.topCenter,
                              child: Icon(
                                Icons.av_timer_rounded,
                                color: AppColors.whiteColor,
                                size: 14,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              width: 40,
                              height: 16,
                              child: Text(
                                  "${recipe.prepareTime.truncate()} min ",
                                  style: AppTextStyles.smallerTextSmallLabel
                                      .copyWith(color: Colors.white)),
                            ),
                            Container(
                                alignment: Alignment.topCenter,
                                child: bookMarkButton(recipe: recipe))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

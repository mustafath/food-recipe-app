import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/screens/main_menu/view/main_menu.dart';
import 'package:food_recipe_app/utils/utils.dart';
import 'package:kartal/kartal.dart';

import '../../../componenets/app_text_field.dart';
import '../../main_menu/viewmodel/main_menu_cubit.dart';

class SearchRecipe extends StatelessWidget {
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
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: AppColors.backgroundColor,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.1),
            ),
            Text(
              'Search Recipe',
              style: AppTextStyles.headerTextBold,
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            AppTextField(
              hintText: 'Search Recipe',
              controller: context.watch<MainMenuCubit>().searchController,
            ),
            SizedBox(
              height: context.dynamicHeight(0.04),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: context.watch<MainMenuCubit>().recipes.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: CustomCard(
                          imageUrl: context
                                  .watch<MainMenuCubit>()
                                  .recipes[index]
                                  .actualImageURL ??
                              "",
                          title: context
                              .watch<MainMenuCubit>()
                              .recipes[index]
                              .name,
                          creator: 'Mustafa Girgin',
                          rating: 4.5));
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String creator;
  final double rating;

  CustomCard({
    required this.imageUrl,
    required this.title,
    required this.creator,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
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
                          rating.toString(),
                          style:
                              textTheme.caption?.copyWith(color: Colors.black),
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
                        child: Text(title,
                            style: AppTextStyles.smallTextBold
                                .copyWith(color: Colors.white))),
                  ),
                  SizedBox(height: 3),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "By $creator",
                        style: AppTextStyles.smallerTextSmallLabel
                            .copyWith(color: Colors.white),
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
    );
  }
}

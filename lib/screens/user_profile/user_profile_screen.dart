// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_recipe_app/models/user.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';
import 'package:food_recipe_app/screens/user_profile/user_profile.dart';
import 'package:food_recipe_app/utils/utils.dart';

import '../../models/recipe.dart';
import '../recipe_detail/view/recipe_detail.dart';

class UserProfile extends StatelessWidget {
  UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()
        ..getRecipes(

            // userBaseModel.recipes ??
            [
              "44a22616-018b-4636-b579-e8713e5d58a9",
              "47dddfca-726c-43c1-9882-253961a81690",
              "4901cef5-f2f4-4da0-a546-4e5ac586c467",
              "5fe69000-b9fc-405e-a67f-d1ab059a5eed",
              "9e53e4b1-ac27-48ad-8b82-0d56cb5015c3",
              "ec1b8523-3c5b-4042-b27d-eb3ee4f696e8",
              "f42bc67d-7b87-4156-9988-d7c30eb1b035"
            ]),
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return buildScaffold(context);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
          child: context.watch<UserProfileCubit>().userBaseModel == null
              ? Container()
              : Container(
                  width: double.infinity,
                  color: AppColors.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(context
                                        .watch<UserProfileCubit>()
                                        .userBaseModel!
                                        .imageUrl ??
                                    ""),
                              ),
                              _textAndNumberColumn('Recipes', 0),
                              _textAndNumberColumn('Followers', 0),
                              _textAndNumberColumn('Following', 0),
                            ],
                          ),
                        ).paddingTop(10),
                        Container(
                                child: _nameAndBio(
                                    context
                                        .watch<UserProfileCubit>()
                                        .userBaseModel!
                                        .name,
                                    context
                                        .watch<UserProfileCubit>()
                                        .userBaseModel!
                                        .bio))
                            .paddingTop(15),
                        Text(
                          "Recipes",
                          style: AppTextStyles.largeTextBold,
                        ).paddingTop(15),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: context
                                  .watch<UserProfileCubit>()
                                  .recipes
                                  .length,
                              itemBuilder: (context, index) {
                                return SavedCard(
                                  recipe: context
                                      .watch<UserProfileCubit>()
                                      .recipes[index],
                                ).paddingTop(10);
                              }),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }

  Widget _nameAndBio(String name, String bio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: AppTextStyles.normalTextBold
                .copyWith(color: AppColors.blackColor)),
        SizedBox(height: 5),
        Text(
            "aşdkfjasşldfjkasidfoşk lşadkfiaşdfklai iaşlfkasiflş aişfklasflş iaşldfkidlş",
            style: AppTextStyles.smallerTextRegular
                .copyWith(color: AppColors.blackColor)),
      ],
    );
  }

  Widget _textAndNumberColumn(String text, int number) {
    return Column(
      children: [
        Text(
          text,
          style: AppTextStyles.smallerTextRegular
              .copyWith(color: AppColors.neutralGray),
        ),
        SizedBox(height: 2),
        Text(
          number.toString(),
          style: AppTextStyles.largeTextBold,
        )
      ],
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
                    SizedBox(height: 3),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(recipe.name,
                                style: AppTextStyles.smallTextBold
                                    .copyWith(color: Colors.white)),
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

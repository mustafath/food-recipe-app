// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:food_recipe_app/extensions/widget.dart';
import 'package:food_recipe_app/screens/reviews/reviews_view.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';

import '../../../componenets/small_button.dart';
import '../../../extensions/colors.dart';
import '../../../extensions/text_style.dart';
import '../../../models/recipe.dart';
import '../../service/auth_service.dart';

class RecipeDetail extends StatelessWidget {
  Recipe recipe;
  RecipeDetail({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.blackColor,
        actions: [
          PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              icon: Icon(Icons.more_horiz_rounded),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(
                          width: 18,
                        ),
                        Text("Share"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.star),
                        SizedBox(
                          width: 18,
                        ),
                        Text("Rate Recipe"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(
                          width: 18,
                        ),
                        Text("Review"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(Icons.bookmark_outline),
                        SizedBox(
                          width: 18,
                        ),
                        Text("Save/Unsave"),
                      ],
                    ),
                  ),
                ];
              })
        ],
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailCard(
                recipe: recipe,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        recipe.name,
                        style: AppTextStyles.smallTextBold,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reviews(
                                      recipe: recipe,
                                    )));
                      },
                      child: Container(
                        child: Text(
                            "(${(recipe.reviews?.length ?? "").toString()} Reviews)",
                            style: AppTextStyles.labelRegular
                                .copyWith(color: AppColors.secondaryTextColor)),
                      ),
                    ),
                  ],
                ),
              ).paddingTop(10),
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.accentColor,
                      radius: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mustafa Girgin",
                          style: AppTextStyles.smallTextBold,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: AppColors.accentColor,
                            ),
                            Text("Ankara, Turkey"),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    CustomSmallButton(
                      onPressed: () {},
                      text: "Follow",
                    )
                  ],
                ),
              ).paddingTop(30),
              IngredientAndProcedure(
                recipe: recipe,
              ).paddingTop(28)
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientAndProcedure extends StatefulWidget {
  Recipe recipe;
  IngredientAndProcedure({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _IngredientAndProcedureState createState() => _IngredientAndProcedureState();
}

class _IngredientAndProcedureState extends State<IngredientAndProcedure> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 150, child: buildTab(text: "Ingridents", index: 0)),
              Container(
                  width: 150, child: buildTab(text: "Procedure", index: 1)),
            ],
          ).paddingTop(20),
          selectedIndex == 0 ? ingredientsBuild() : procedureBuild(),
        ],
      ),
    );
  }

  Widget ingredientsBuild() {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.recipe.ingredients.length,
            itemBuilder: (context, item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 76,
                    color: AppColors.neutralGray.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: [
                      Text(
                        widget.recipe.ingredients[item].name,
                        style: AppTextStyles.normalTextBold
                            .copyWith(color: AppColors.blackColor),
                      ),
                      Spacer(),
                      Text(
                        "${widget.recipe.ingredients[item].quantity}g",
                        style: AppTextStyles.smallTextRegular
                            .copyWith(color: AppColors.secondaryTextColor),
                      )
                    ]),
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget procedureBuild() {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.recipe.steps.length,
            itemBuilder: (context, item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: 93,
                    color: AppColors.neutralGray.withOpacity(0.5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Step ${widget.recipe.steps[item].stepNo + 1}",
                              style: AppTextStyles.smallerTextBold
                                  .copyWith(color: AppColors.blackColor)),
                          Text(widget.recipe.steps[item].stepDescription,
                              style: AppTextStyles.smallerTextRegular.copyWith(
                                  color: AppColors.secondaryTextColor))
                        ]),
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget buildTab({required String text, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          color: selectedIndex == index
              ? AppColors.accentColor
              : Colors.transparent,
          child: Text(
            text,
            style: AppTextStyles.smallTextBold.copyWith(
                color: selectedIndex == index
                    ? Colors.white
                    : AppColors.accentColor),
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  Recipe recipe;

  DetailCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(recipe.actualImageURL ?? ""),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    padding: EdgeInsets.all(3),
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
                          "4.5",
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
                  SizedBox(height: 3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          child: Text("${recipe.prepareTime.truncate()} min ",
                              style: AppTextStyles.smallerTextSmallLabel
                                  .copyWith(color: Colors.white)),
                        ),
                        bookMarkButton(recipe: recipe),
                      ],
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

class bookMarkButton extends StatefulWidget {
  const bookMarkButton({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  State<bookMarkButton> createState() => _bookMarkButtonState();
}

class _bookMarkButtonState extends State<bookMarkButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            if (AuthService.instance.loggedInUser!.savedRecipes
                .contains(widget.recipe.id)) {
              AuthService.instance.loggedInUser!.savedRecipes
                  .remove(widget.recipe.id);
            } else {
              AuthService.instance.loggedInUser!.savedRecipes
                  .add(widget.recipe.id);
            }

            FirestoreService.instance.updateData(
                collection: "users",
                data: {
                  "savedRecipes":
                      AuthService.instance.loggedInUser!.savedRecipes
                },
                documentId: AuthService.instance.loggedInUser!.id);

            setState(() {});
          },
          child: AuthService.instance.loggedInUser!.savedRecipes
                  .contains(widget.recipe.id)
              ? Icon(Icons.bookmark, color: AppColors.whiteColor, size: 14)
              : Icon(Icons.bookmark_outline,
                  color: AppColors.whiteColor, size: 14),
        ));
  }
}

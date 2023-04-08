// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_recipe_app/extensions/colors.dart';
import 'package:food_recipe_app/extensions/text_style.dart';
import 'package:food_recipe_app/screens/splash_screen/splash_screen.dart';

import '../../../models/recipe.dart';

class PlateView extends StatelessWidget {
  Recipe recipe;
  PlateView({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 150,
            height: 231,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: 150,
                      height: 175,
                      color: AppColors.neutralGray,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 130,
                              height: 110,
                              child: Text(recipe.name,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.smallTextBold)
                                  .paddingTop(66),
                            ),
                            Text(
                              "Time",
                              style: AppTextStyles.smallerTextRegular,
                            ).paddingTop(19),
                            Row(
                              children: [
                                Text(
                                  "${recipe.prepareTime.truncate()} min",
                                  style: AppTextStyles.smallerTextBold,
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: 110,
                    height: 110,
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      backgroundImage: NetworkImage(
                        recipe.plateImageURL ?? "",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

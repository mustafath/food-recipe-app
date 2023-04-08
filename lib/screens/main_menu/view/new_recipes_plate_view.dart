// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../Extensions/colors.dart';
import '../../../models/recipe.dart';

class NewRecipesPlate extends StatelessWidget {
  Recipe recipe;
  NewRecipesPlate({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: 251,
      height: 127,
      child: Stack(children: [
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: 251,
              height: 95,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        Positioned(
          right: 10,
          child: Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: AppColors.accentColor,
              backgroundImage: NetworkImage(recipe.plateImageURL ?? ""),
            ),
          ),
        )
      ]),
    );
  }
}

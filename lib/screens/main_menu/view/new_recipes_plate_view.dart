// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_recipe_app/extensions/text_style.dart';

import '../../../Extensions/colors.dart';
import '../../../models/recipe.dart';

class NewRecipesPlate extends StatefulWidget {
  Recipe recipe;
  NewRecipesPlate({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<NewRecipesPlate> createState() => _NewRecipesPlateState();
}

class _NewRecipesPlateState extends State<NewRecipesPlate> {
  double rates = 0;

  @override
  void initState() {
    rates = 0;

    widget.recipe.reviews?.forEach((element) {
      rates += element?.rating ?? 0;
    });

    int len = widget.recipe.reviews?.length ?? 1;
    len = len == 0 ? 1 : len;

    rates = rates / (len);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: 280,
      height: 127,
      child: Stack(children: [
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.all(10),
              width: 280,
              height: 95,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        width: 130,
                        child: Text(
                          widget.recipe.name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.smallTextBold,
                        ),
                      ),
                    ),
                    RatingBarIndicator(
                      itemCount: 5,
                      itemSize: 10.0,
                      direction: Axis.horizontal,
                      rating: rates,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25,
                          child: CircleAvatar(
                            backgroundColor: AppColors.accentColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("By Mustafa Girgin",
                            style: AppTextStyles.smallerTextRegular
                                .copyWith(color: AppColors.secondaryTextColor)),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.av_timer,
                          color: AppColors.secondaryTextColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.recipe.prepareTime.truncate()} min",
                          style: AppTextStyles.smallerTextRegular
                              .copyWith(color: AppColors.secondaryTextColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 0,
          child: Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: AppColors.accentColor,
              backgroundImage: NetworkImage(widget.recipe.plateImageURL ?? ""),
            ),
          ),
        )
      ]),
    );
  }
}

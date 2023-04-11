// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_recipe_app/componenets/app_text_field.dart';
import 'package:food_recipe_app/screens/reviews/comment_view.dart';
import 'package:food_recipe_app/screens/reviews/review_cubit.dart';
import 'package:food_recipe_app/utils/utils.dart';

import '../../extensions/colors.dart';
import '../../models/recipe.dart';

class Reviews extends StatelessWidget {
  Recipe recipe;
  Reviews({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {},
      builder: (context, state) {
        return buildScaffold(context);
      },
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          "Reviews",
          style: AppTextStyles.mediumTextBold.copyWith(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Leave a comment",
                style: AppTextStyles.smallTextRegular,
              ),
              AppTextField(
                  maxLength: 120,
                  maxLines: 3,
                  hintText: "Say something",
                  controller: context.read<ReviewCubit>().commentController),
              Row(
                children: [
                  RatingBar.builder(
                    glowColor: AppColors.accentColor,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.accentColor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      context.read<ReviewCubit>().ratingController = rating;
                    },
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      context.read<ReviewCubit>().sendComment(recipe.id);
                    },
                    child: Text("Send"),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.accentColor)),
                  ),
                ],
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recipe.reviews?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CommentView(review: recipe.reviews![index]!),
                    );
                  }),
              SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}

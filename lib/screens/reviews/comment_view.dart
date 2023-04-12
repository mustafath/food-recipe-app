// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_recipe_app/models/user.dart';
import 'package:food_recipe_app/screens/service/firestore_service.dart';
import 'package:food_recipe_app/screens/user_profile/user_profile_screen.dart';
import 'package:food_recipe_app/utils/utils.dart';
import 'package:intl/intl.dart';

import '../../models/review.dart';

class CommentView extends StatefulWidget {
  Review review;
  CommentView({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  UserDisplayModel? user;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      FirestoreService.instance.getUserById(widget.review.userId).then((value) {
        user = UserDisplayModel.fromMap(value.data() as Map<String, dynamic>);
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: AppColors.neutralGray.withOpacity(0.5),
        padding: EdgeInsets.all(10),
        height: 100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  if (user == null) {
                    return;
                  }

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => UserProfile(
                  //               userBaseModel: user!,
                  //             )));
                },
                child: CircleAvatar(
                  radius: 15,
                ),
              ),
              SizedBox(
                width: 9,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? "",
                    style: AppTextStyles.smallerTextBold,
                  ),
                  Text(
                      DateFormat("MMMM dd, yyyy - HH:mm")
                          .format(widget.review.timestamp),
                      style: AppTextStyles.smallerTextRegular),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.review.comment, style: AppTextStyles.smallerTextRegular)
        ]),
      ),
    );
  }
}

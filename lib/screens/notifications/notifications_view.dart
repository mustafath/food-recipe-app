import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_recipe_app/extensions/widget.dart';
import 'package:food_recipe_app/utils/utils.dart';

import '../../extensions/colors.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          color: AppColors.backgroundColor,
          height: double.infinity,
          child: Column(
            children: [SegmentedController()],
          )),
    );
  }
}

class SegmentedController extends StatefulWidget {
  @override
  _SegmentedControllerState createState() => _SegmentedControllerState();
}

class _SegmentedControllerState extends State<SegmentedController> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 40,
                  width: 100,
                  child: buildTab(text: "All", index: 0)),
              Container(
                  height: 40,
                  width: 100,
                  child: buildTab(text: "Read", index: 1)),
              Container(
                  height: 40,
                  width: 100,
                  child: buildTab(text: "Unread", index: 2)),
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
            itemCount: 0,
            itemBuilder: (context, item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 76,
                    color: AppColors.neutralGray.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: []),
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
            itemCount: 0,
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
                        children: []),
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
        borderRadius: BorderRadius.circular(10),
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

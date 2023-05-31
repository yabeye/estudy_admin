import 'package:estudy_admin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Obx(() => Container(
          height: 400,
          child: Column(
            children: [
              InfoCardSmall(
                title: "Total Users",
                value: usersController.users.length.toString(),
                onTap: () {},
                isActive: true,
              ),
              SizedBox(
                height: _width / 64,
              ),
              InfoCardSmall(
                title: "Total Questions",
                value: questionsController.questions.length.toString(),
                onTap: () {},
              ),
              SizedBox(
                height: _width / 64,
              ),
              InfoCardSmall(
                title: "Total Answers",
                value: questionsController.answers.length.toString(),
                onTap: () {},
              ),
              SizedBox(
                height: _width / 64,
              ),
              InfoCardSmall(
                title: "Total Files",
                value: questionsController.files.length.toString(),
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}

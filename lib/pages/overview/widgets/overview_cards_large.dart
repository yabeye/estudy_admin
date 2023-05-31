import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/pages/overview/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Obx(() => Row(
          children: [
            InfoCard(
              title: "Total Users",
              value: usersController.users.length.toString(),
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Total Questions",
              value: questionsController.questions.length.toString(),
              topColor: Colors.lightGreen,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Total Answers",
              value: questionsController.answers.length.toString(),
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Total Files",
              value: questionsController.files.length.toString(),
              onTap: () {},
            ),
          ],
        ));
  }
}

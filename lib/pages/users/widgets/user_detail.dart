import 'package:estudy_admin/constants/extensions.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../constants/controllers.dart';
import '../../../models/user_model.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key, required this.user});
  final User user;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    updateUser(String key) async {
      (user.awards ?? []).add(key);
      setState(() {});
      await usersController.updateUser(
        id: user.id ?? "",
        isActive: user.isActive,
        awards: user.awards,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          50.height,
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "User Details",
              style: boldTextStyle(size: 22),
            ),
          ),
          SizedBox(
            height: context.height() * .4,
            width: context.width() * .9,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 5,
              ),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.man),
                    title: const Text('Full Name'),
                    subtitle: Text("${user.firstName} ${user.lastName ?? ""}"),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.abc),
                    title: const Text('Username'),
                    subtitle: Text(user.username ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Role'),
                    subtitle: Text(user.roles ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(user.email ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(user.phone ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(user.email ?? ""),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.question_mark),
                    title: const Text('Questions Asked'),
                    subtitle: Text(user.question.length.toString()),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.question_answer),
                    title: const Text('Answers'),
                    subtitle: Text(user.answer.length.toString()),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.file_copy),
                    title: Text('Files Uploads'),
                    subtitle: Text("0"),
                  ),
                ),
              ],
            ),
          ),
          // 20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Awards",
              style: boldTextStyle(size: 22),
            ),
          ).paddingSymmetric(horizontal: 12),
          Row(
            children: [
              Row(
                children: [
                  "assets/icons/basic.svg"
                      .svgImage(size: 72, color: Colors.grey)
                      .paddingRight(12),
                  const Text("Basic Contribution Badge"),
                ],
              ).paddingRight(22).visible((user.awards ?? []).contains("B")),
              Row(
                children: [
                  "assets/icons/silver.svg"
                      .svgImage(size: 72, color: primaryColor)
                      .paddingRight(12),
                  const Text("Silver Badge"),
                ],
              ).paddingRight(22).visible((user.awards ?? []).contains("S")),
              Row(
                children: [
                  "assets/icons/gold.svg".svgImage(size: 72).paddingRight(12),
                  const Text("Gold Badge"),
                ],
              ).paddingRight(22).visible((user.awards ?? []).contains("G")),
            ],
          ),
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Reward Badges",
              style: boldTextStyle(size: 22),
            ),
          ).paddingSymmetric(horizontal: 12).paddingRight(22),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  "assets/icons/basic.svg"
                      .svgImage(size: 72, color: Colors.grey)
                      .paddingRight(12),
                  AppButton(
                    onTap: () async => await updateUser("B"),
                    text: "Basic Contribution Badge",
                    // textColor: Colors.white,
                    // color: Colors.amber,
                  ),
                ],
              ).visible(!(user.awards ?? []).contains("B")).paddingRight(22),
              Row(
                children: [
                  "assets/icons/silver.svg"
                      .svgImage(size: 72, color: primaryColor)
                      .paddingRight(12),
                  AppButton(
                    onTap: () async => await updateUser("S"),
                    text: "Silver Badge",
                    textColor: Colors.white,
                    color: primaryColor,
                  ),
                ],
              ).visible(!(user.awards ?? []).contains("S")).paddingRight(22),
              Row(
                children: [
                  "assets/icons/gold.svg".svgImage(size: 72).paddingRight(12),
                  AppButton(
                    onTap: () async => await updateUser("G"),
                    text: "Gold Badge",
                    textColor: Colors.white,
                    color: Colors.amber,
                  )
                ],
              ).visible(!(user.awards ?? []).contains("G")).paddingRight(22),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}

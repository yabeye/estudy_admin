import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:estudy_admin/pages/users/widgets/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() async {
      _searchController.text = usersController.searchKeyWord.value;
      await usersController.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: size.width * .2,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search uses ...",
                ),
                onChanged: (c) {
                  usersController.searchKeyWord.value = c;
                },
              ),
            ),
          ),
          Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: radius(),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FontAwesomeIcons.searchengin,
                        color: Colors.white,
                      ),
                      Text(
                        "Search Applied",
                        style: primaryTextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ).paddingAll(8),
                ),
              ).visible(usersController.searchKeyWord.isNotEmpty)),
          Expanded(
            child: Obx(() => ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: active.withOpacity(.4), width: .5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 6),
                              color: appLightGrey.withOpacity(.1),
                              blurRadius: 12)
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 30),
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text('Id',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          DataColumn(
                            label: Text('Full Name',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          DataColumn(
                            label: Text('Email',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          DataColumn(
                            label: Text('Role',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          DataColumn(
                            label: Text(
                              'Questions Asked',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // DataColumn(
                          //   label: Text('Files upload',
                          //       style: TextStyle(
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.bold,
                          //       )),
                          // ),
                          DataColumn(
                            label: Text('',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          DataColumn(
                            label: Text('',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          // DataColumn(
                          //   label: Text('',
                          //       style: TextStyle(
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.bold,
                          //       )),
                          // ),
                        ],
                        rows: List.generate(
                            (usersController.users.where(
                              (p0) =>
                                  (p0.firstName ?? "").toLowerCase().contains(
                                      usersController.searchKeyWord) ||
                                  (p0.lastName ?? "").toLowerCase().contains(
                                        usersController.searchKeyWord,
                                      ),
                            )).length, (index) {
                          final user = [
                            ...usersController.users.where((p0) =>
                                (p0.firstName ?? "")
                                    .toLowerCase()
                                    .contains(usersController.searchKeyWord) ||
                                (p0.lastName ?? "").toLowerCase().contains(
                                      usersController.searchKeyWord,
                                    ))
                          ][index];
                          return DataRow(
                              onLongPress: () {
                                UserDetail(user: user).launch(
                                  context,
                                  isNewTask: false,
                                );
                              },
                              cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(Text(
                                    "${user.firstName ?? ""} ${user.lastName ?? ""}")),
                                DataCell(Text(user.email ?? "")),
                                DataCell(Text(user.roles ?? "User")),
                                DataCell(Text(user.question.length.toString())),
                                // DataCell(Text("0")),
                                // DataCell(
                                //   TextButton(
                                //       onPressed: () {},
                                //       child: const Text(
                                //         "Suspend",
                                //         style: TextStyle(
                                //           color: Colors.red,
                                //         ),
                                //       )),
                                // ),
                                DataCell(
                                  TextButton(
                                    onPressed: () async {
                                      await usersController.updateUser(
                                        id: user.id ?? "",
                                        isActive: !user.isActive,
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        user.isActive
                                            ? Colors.yellow.shade900
                                            : Colors.green,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      user.isActive ? "Block" : "Unblock",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  TextButton(
                                    onPressed: () async {
                                      await usersController.deleteUser(
                                        id: user.id ?? "",
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.red,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                        }),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}

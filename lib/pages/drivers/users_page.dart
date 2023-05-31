import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    afterBuildCreated(() async {
      await usersController.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            label: Text('Questions Asked',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                )),
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
                          // DataColumn(
                          //   label: Text('',
                          //       style: TextStyle(
                          //         fontSize: 22,
                          //         fontWeight: FontWeight.bold,
                          //       )),
                          // ),
                        ],
                        rows: List.generate(usersController.users.length,
                            (index) {
                          final user = usersController.users[index];
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text((user.firstName ?? "") +
                                " " +
                                (user.lastName ?? ""))),
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
                                    user.isActive ? Colors.red : Colors.green,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  user.isActive ? "Block" : "Unblock",
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

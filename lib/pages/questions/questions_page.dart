import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:estudy_admin/pages/questions/widgets/question_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../api/exceptions.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const LinearProgressIndicator().visible(_isLoading),
          const SizedBox(height: 10),
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
                                color: lightGrey.withOpacity(.1),
                                blurRadius: 12)
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 30),
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
                              label: Text('Title',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            DataColumn(
                              label: Text('Category',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            DataColumn(
                              label: Text('Subject',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),

                            DataColumn(
                              label: Text('Total Answers',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            DataColumn(
                              label: Text('Created At',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            DataColumn(
                              label: Text('Reports',
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
                              questionsController.questions.length, (i) {
                            final questions = questionsController.questions;
                            // Add somethig
                            return DataRow(
                                onLongPress: () async {
                                  // await usersController.updateUser(
                                  //   id: user.id ?? "",
                                  //   isActive: !user.isActive,
                                  // );
                                  QuestionDetail(question: questions[i]).launch(
                                    context,
                                    isNewTask: false,
                                  );
                                },
                                color: MaterialStateColor.resolveWith((states) {
                                  if (states.contains(MaterialState.selected) ||
                                      (questions[i].reportedBy ?? [])
                                          .isNotEmpty) {
                                    // Set the color for the selected state
                                    return danger.withOpacity(0.1);
                                  }
                                  // Set the default color for the row
                                  return Colors.white;
                                }),
                                cells: [
                                  DataCell(Text((i + 1).toString())),
                                  DataCell(Text(questions[i].title)),
                                  DataCell(Text(questions[i].category)),
                                  DataCell(Text(questions[i].subject)),
                                  DataCell(Text(
                                      questions[i].answers.length.toString())),
                                  DataCell(
                                      Text(questions[i].createdAt.timeAgo)),
                                  DataCell(
                                    SizedBox(
                                      width: size.width * .05,
                                      child: (questions[i].reportedBy).isEmpty
                                          ? const Text("no reports")
                                          : TextScroll(
                                              ((questions[i].reportedBy))
                                                  .map((e) =>
                                                      (e["report"] ?? ""))
                                                  .join(", "),
                                              velocity: const Velocity(
                                                  pixelsPerSecond:
                                                      Offset(40, 0)),
                                              style: secondaryTextStyle(),
                                            ),
                                    ),
                                  ),
                                  DataCell(TextButton(
                                    onPressed: () async {
                                      try {
                                        await questionsController
                                            .updateQuestion(
                                          id: questions[i].id,
                                          isActive: !questions[i].isActive,
                                        );
                                        // ignore: use_build_context_synchronously
                                        toasty(
                                          context,
                                          questions[i].isActive
                                              ? "Deactivated"
                                              : "Activated",
                                        );
                                      } on BadRequestException catch (e) {
                                        toasty(context, e.message);
                                      } on UnAuthorizedException catch (e) {
                                        toasty(context, e.message);
                                      } on FetchDataException catch (e) {
                                        toasty(context, e.message);
                                      } catch (e) {
                                        toasty(
                                          context,
                                          "We are unable to do that !",
                                        );
                                      }
                                    },
                                    child: Text(
                                      questions[i].isActive
                                          ? "Deactivate"
                                          : "Activate",
                                      style: TextStyle(
                                        color: questions[i].isActive
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  )),
                                  DataCell(
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          await questionsController
                                              .deleteQuestion(
                                            id: questions[i].id,
                                          );
                                          // ignore: use_build_context_synchronously
                                          toasty(
                                            context,
                                            "Delete Successfully",
                                          );
                                        } on BadRequestException catch (e) {
                                          toasty(context, e.message);
                                        } on UnAuthorizedException catch (e) {
                                          toasty(context, e.message);
                                        } on FetchDataException catch (e) {
                                          toasty(context, e.message);
                                        } catch (e) {
                                          toasty(
                                            context,
                                            "We are unable to do that!",
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
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
                  ))),
        ],
      ),
    );
  }
}

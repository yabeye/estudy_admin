import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:estudy_admin/pages/overview/widgets/bar_chart.dart';
import 'package:estudy_admin/pages/overview/widgets/revenue_info.dart';
import 'package:estudy_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueSectionLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: appLightGrey.withOpacity(.1),
                  blurRadius: 12)
            ],
            border: Border.all(color: appLightGrey, width: .5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: "Questions Graph",
                      size: 20,
                      weight: FontWeight.bold,
                      color: appLightGrey,
                    ),
                    SizedBox(
                      width: 600,
                      height: 200,
                      child: SimpleBarChart.withSampleData(),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 120,
                color: appLightGrey,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        RevenueInfo(
                          title: "Biology",
                          amount: questionsController
                              .filter("Biology")
                              .length
                              .toString(),
                        ),
                        RevenueInfo(
                          title: "Chemistry",
                          amount: questionsController
                              .filter("Chemistry")
                              .length
                              .toString(),
                        ),
                        RevenueInfo(
                          title: "Physics",
                          amount: questionsController
                              .filter("Physics")
                              .length
                              .toString(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        RevenueInfo(
                          title: "Geography",
                          amount: questionsController
                              .filter("Geography")
                              .length
                              .toString(),
                        ),
                        RevenueInfo(
                          title: "History",
                          amount: questionsController
                              .filter("History")
                              .length
                              .toString(),
                        ),
                        RevenueInfo(
                          title: "Civics",
                          amount: questionsController
                              .filter("Civics")
                              .length
                              .toString(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        RevenueInfo(
                          title: "Math",
                          amount: questionsController
                              .filter("Math")
                              .length
                              .toString(),
                        ),
                        RevenueInfo(
                          title: "Languages",
                          amount: questionsController
                              .filter("Languages")
                              .length
                              .toString(),
                        ),
                        RevenueInfo(
                          title: "Others",
                          amount: questionsController
                              .filter("Others")
                              .length
                              .toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

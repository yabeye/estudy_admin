import 'package:estudy_admin/constants/style.dart';
import 'package:estudy_admin/pages/overview/widgets/bar_chart.dart';
import 'package:estudy_admin/pages/overview/widgets/revenue_info.dart';
import 'package:estudy_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RevenueSectionLarge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: applightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: applightGrey, width: .5),
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
                  color: applightGrey,
                ),
                Container(
                    width: 600,
                    height: 200,
                    child: SimpleBarChart.withSampleData()),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 120,
            color: applightGrey,
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Biology",
                      amount: "12",
                    ),
                    RevenueInfo(
                      title: "Chemistry",
                      amount: "10",
                    ),
                    RevenueInfo(
                      title: "Physics",
                      amount: "10",
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    RevenueInfo(
                      title: "Geography",
                      amount: "30",
                    ),
                    RevenueInfo(
                      title: "History",
                      amount: "11",
                    ),
                    RevenueInfo(
                      title: "Civics",
                      amount: "10",
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    RevenueInfo(
                      title: "Math",
                      amount: "30",
                    ),
                    RevenueInfo(
                      title: "Languages",
                      amount: "0",
                    ),
                    RevenueInfo(
                      title: "Others",
                      amount: "1",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

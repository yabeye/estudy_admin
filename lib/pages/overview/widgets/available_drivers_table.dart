import 'package:data_table_2/data_table_2.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../widgets/custom_text.dart';

/// Example without datasource
class AvailableDriversTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: applightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     CustomText(
          //       text: "Regional Data",
          //       color: lightGrey,
          //       weight: FontWeight.bold,
          //     ),
          //     CustomText(
          //       text: "",
          //       color: lightGrey,
          //       weight: FontWeight.bold,
          //     ),
          //     CustomText(
          //       text: "",
          //       color: lightGrey,
          //       weight: FontWeight.bold,
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SfCircularChart(
                  title: ChartTitle(text: 'Regional Data'),
                  series: <CircularSeries>[
                    // Render pie chart

                    PieSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ]),
              SizedBox(
                width: context.width * .6,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Users Growth'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: _tooltipBehavior,
                  series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData('May', 12),
                          SalesData('Jun', 22),
                          SalesData('Jul', 44),
                          SalesData('Aug', 33),
                          SalesData('Sep', 50),
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        name: 'Questions',
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                    LineSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        SalesData('May', 0),
                        SalesData('Jun', 10),
                        SalesData('Jul', 12),
                        SalesData('Aug', 23),
                        SalesData('Sep', 40)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      name: 'Answers',
                    ),
                    LineSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        SalesData('May', 0),
                        SalesData('Jun', 2),
                        SalesData('Jul', 5),
                        SalesData('Aug', 10),
                        SalesData('Sep', 12)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      name: 'Users',
                    ),
                  ],
                ),
              ),
            ],
          ), // DataTable2(
          //     columnSpacing: 12,
          //     horizontalMargin: 12,
          //     minWidth: 600,
          //     columns: [
          //       DataColumn2(
          //         label: Text("Name"),
          //         size: ColumnSize.L,
          //       ),
          //       DataColumn(
          //         label: Text('Location'),
          //       ),
          //       DataColumn(
          //         label: Text('Rating'),
          //       ),
          //       DataColumn(
          //         label: Text('Action'),
          //       ),
          //     ],
          //     rows: List<DataRow>.generate(
          //         1,
          //         (index) => DataRow(cells: [
          //               DataCell(CustomText(text: "Admin")),
          //               DataCell(CustomText(text: "Addis Ababa")),
          //               DataCell(Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   Icon(
          //                     Icons.star,
          //                     color: Colors.deepOrange,
          //                     size: 18,
          //                   ),
          //                   SizedBox(
          //                     width: 5,
          //                   ),
          //                   CustomText(
          //                     text: "4.5",
          //                   )
          //                 ],
          //               )),
          //               DataCell(Container(
          //                   decoration: BoxDecoration(
          //                     color: light,
          //                     borderRadius: BorderRadius.circular(20),
          //                     border: Border.all(color: active, width: .5),
          //                   ),
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: 12, vertical: 6),
          //                   child: CustomText(
          //                     text: "Assign Delivery",
          //                     color: active.withOpacity(.7),
          //                     weight: FontWeight.bold,
          //                   ))),
          //             ]))),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../helpers/reponsiveness.dart';

/// Example without datasource
class AvailableDriversTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

    return Obx(() {
      final List<ChartData> chartData = [
        ChartData(
          'Addis Ababa',
          questionsController.questions.length.toDouble(),
        ),
        ChartData(
            'Oroomiya', questionsController.questions.length.toDouble() * .05),
        ChartData('Tigray', 0),
        ChartData('Amhara', 0),
        ChartData('DireDawa', 0),
        ChartData('Debub', 0),
        ChartData(
            'Others', questionsController.questions.length.toDouble() * .05),
      ];
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              RowGrowthGraph(
                chartData: chartData,
                tooltipBehavior: tooltipBehavior,
              )
            else
              ColumnGrowthGraph(
                chartData: chartData,
                tooltipBehavior: tooltipBehavior,
              ),
          ],
        ),
      );
    });
  }
}

class RowGrowthGraph extends StatelessWidget {
  const RowGrowthGraph({
    super.key,
    required this.chartData,
    required TooltipBehavior tooltipBehavior,
  }) : _tooltipBehavior = tooltipBehavior;

  final List<ChartData> chartData;
  final TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SfCircularChart(
          tooltipBehavior: _tooltipBehavior,
          title: ChartTitle(text: 'Regional Data\n(AA to other regions)'),
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              animationDuration: 0,
            )
          ],
          legend: Legend(
            isVisible: true,
            position: LegendPosition.right,
          ),
        ),
        SizedBox(
          width: context.width * .5,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Growth Graph'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<GraphData, String>>[
              LineSeries<GraphData, String>(
                dataSource: questionsController
                    .getYearData(questionsController.questions),
                xValueMapper: (GraphData sales, _) => sales.year,
                yValueMapper: (GraphData sales, _) => sales.sales,
                name: 'Questions',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                animationDuration: 0,
              ),
              LineSeries<GraphData, String>(
                dataSource: questionsController
                    .getYearData(questionsController.answers),
                xValueMapper: (GraphData sales, _) => sales.year,
                yValueMapper: (GraphData sales, _) => sales.sales,
                name: 'Answers',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                animationDuration: 0,
              ),
              LineSeries<GraphData, String>(
                dataSource:
                    questionsController.getYearData(usersController.users),
                xValueMapper: (GraphData sales, _) => sales.year,
                yValueMapper: (GraphData sales, _) => sales.sales,
                name: 'Users',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                animationDuration: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColumnGrowthGraph extends StatelessWidget {
  const ColumnGrowthGraph({
    super.key,
    required this.chartData,
    required TooltipBehavior tooltipBehavior,
  }) : _tooltipBehavior = tooltipBehavior;

  final List<ChartData> chartData;
  final TooltipBehavior _tooltipBehavior;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SfCircularChart(
          title: ChartTitle(text: 'Regional Data\nAA to other regions'),
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
                animationDuration: 0,
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ],
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
          ),
        ),
        SizedBox(
          width: context.width * 1,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Growth Graph'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<GraphData, String>>[
              LineSeries<GraphData, String>(
                animationDuration: 0,
                dataSource: questionsController
                    .getYearData(questionsController.questions),
                xValueMapper: (GraphData sales, _) => sales.year,
                yValueMapper: (GraphData sales, _) => sales.sales,
                name: 'Questions',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
              LineSeries<GraphData, String>(
                animationDuration: 0,
                dataSource: questionsController
                    .getYearData(questionsController.answers),
                xValueMapper: (GraphData sales, _) => sales.year,
                yValueMapper: (GraphData sales, _) => sales.sales,
                name: 'Answers',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
              LineSeries<GraphData, String>(
                animationDuration: 0,
                dataSource:
                    questionsController.getYearData(usersController.users),
                xValueMapper: (GraphData sales, _) => sales.year,
                yValueMapper: (GraphData sales, _) => sales.sales,
                name: 'Users',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class GraphData {
  GraphData(this.year, this.sales);
  String year;
  double sales;
  @override
  String toString() => "GrapthData(year: $year, sales: $sales)";
}

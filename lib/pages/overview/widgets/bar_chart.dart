/// Bar chart example
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {required this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return SimpleBarChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales(
        'Natural Science',
        questionsController.questions
            .where((p) => p.category.toLowerCase() == "natural")
            .length,
      ),
      OrdinalSales(
        'Social Science',
        questionsController.questions
            .where((p) => p.category.toLowerCase() == "social")
            .length,
      ),
      OrdinalSales(
        'Others',
        questionsController.questions
            .where((p) => p.category.toLowerCase() == "others")
            .length,
      ),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Category',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(active),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

import 'package:estudy_admin/pages/clients/questions_page.dart';
import 'package:estudy_admin/pages/drivers/users_page.dart';
import 'package:estudy_admin/pages/overview/overview.dart';
import 'package:flutter/material.dart';
import 'package:estudy_admin/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case driversPageRoute:
      return _getPageRoute(const UsersPage());
    case clientsPageRoute:
      return _getPageRoute(const QuestionsPage());
    default:
      return _getPageRoute(const OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/routing/router.dart';
import 'package:estudy_admin/routing/routes.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: overviewPageRoute,
    );

import 'dart:async';

import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/helpers/reponsiveness.dart';
import 'package:estudy_admin/pages/overview/widgets/available_drivers_table.dart';
import 'package:estudy_admin/pages/overview/widgets/overview_cards_large.dart';
import 'package:estudy_admin/pages/overview/widgets/overview_cards_medium.dart';
import 'package:estudy_admin/pages/overview/widgets/overview_cards_small.dart';
import 'package:estudy_admin/pages/overview/widgets/revenue_section_large.dart';
import 'package:estudy_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../api/exceptions.dart';
import 'widgets/revenue_section_small.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool _isLoading = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() async {
      await fetchAllData();
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        await fetchAllData();
      });

      _isLoading = false;
      setState(() {});
    });
  }

  fetchAllData() async {
    try {
      await usersController.getUsers();
      await questionsController.getAllQuestions();
    } on BadRequestException catch (e) {
      toasty(context, e.message);
    } on UnAuthorizedException catch (e) {
      toasty(context, e.message);
    } on FetchDataException catch (e) {
      toasty(context, e.message);
    } catch (e) {
      toasty(context, "We are unable to do that!");
    }

    setState(() {});
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 20),
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
          // Container(
          //     margin: EdgeInsets.only(
          //         top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
          //     child: CustomText(
          //       text: menuController.activeItem.value,
          //       size: 24,
          //       weight: FontWeight.bold,
          //     )),
          Expanded(
              child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomSize(context))
                  OverviewCardsMediumScreen()
                else
                  OverviewCardsLargeScreen()
              else
                OverviewCardsSmallScreen(),
              if (!ResponsiveWidget.isSmallScreen(context))
                RevenueSectionLarge()
              else
                RevenueSectionSmall(),
              AvailableDriversTable(),
            ],
          ))
        ],
      ),
    );
  }
}

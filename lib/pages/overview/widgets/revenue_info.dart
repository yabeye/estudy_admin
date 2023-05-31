import 'package:estudy_admin/constants/style.dart';
import 'package:flutter/material.dart';

class RevenueInfo extends StatelessWidget {
  final String? title;
  final String? amount;

  const RevenueInfo({Key? key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$title \n\n",
                style: TextStyle(color: applightGrey, fontSize: 16)),
            TextSpan(
                text: "$amount",
                style: TextStyle(
                    color: applightGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ])),
    );
  }
}

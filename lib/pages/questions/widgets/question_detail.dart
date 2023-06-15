import 'package:estudy_admin/models/question_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class QuestionDetail extends StatefulWidget {
  const QuestionDetail({super.key, required this.question});
  final Question question;

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    return Scaffold(
      body: ListView(
        children: [
          50.height,
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          20.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Question Details",
              style: boldTextStyle(size: 22),
            ),
          ),
          30.height,
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Title'),
              subtitle: Text(question.title),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Description'),
              subtitle: Text(question.description),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Category'),
              subtitle: Text(question.category),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Subject'),
              subtitle: Text(question.subject),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Asked'),
              subtitle: Text(question.createdAt.timeAgo),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Up Vote'),
              subtitle: Text(question.voteCount.length.toString()),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Down Vote'),
              subtitle: Text(question.voteCountDown.length.toString()),
            ),
          ),
          Card(
            child: ListTile(
              // leading: const Icon(Icons.question_answer),
              title: const Text('Total Answers'),
              subtitle: Text(question.answers.length.toString()),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}

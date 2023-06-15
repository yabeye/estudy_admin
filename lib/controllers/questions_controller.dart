import 'package:estudy_admin/api/api_provider.dart';
import 'package:estudy_admin/constants/constants.dart';
import 'package:estudy_admin/models/answer_model.dart';
import 'package:estudy_admin/models/question_model.dart';
import 'package:estudy_admin/pages/overview/widgets/available_drivers_table.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  static QuestionsController instance = Get.find();
  var questions = <Question>[].obs;
  var answers = <Answer>[].obs;
  var files = [].obs;

  var searchKeyWord = "".obs;

  final _provider = ApiProvider();

  Future<void> getAllQuestions() async {
    var response = await _provider.get("questions/all");
    var resQuestions = response['data']['questions'];

    // clearQuestions();
    List<Question> temp = [];
    for (int i = 0; i < resQuestions.length; i++) {
      temp.add(Question.fromJson(resQuestions[i]));
    }
    questions.value = temp;
    questions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    response = await _provider.get("files/all");
    resQuestions = response['data']['files'];

    files.value = resQuestions;

    response = await _provider.get("answers");
    resQuestions = response['data']['answers'];
    List<Answer> ans = [];
    for (int i = 0; i < resQuestions.length; i++) {
      ans.add(Answer.fromJson(resQuestions[i]));
    }
    answers.value = ans;
  }

  Future<void> updateQuestion(
      {required String id, required bool isActive}) async {
    await _provider.patch("questions/$id", {
      "isActive": isActive,
    });
    await getAllQuestions();
  }

  Future<void> deleteQuestion({required String id}) async {
    await _provider.delete("questions/$id");
    await getAllQuestions();
  }

  clearQuestions() {
    questions.value = [];
    files.value = [];
    answers.value = [];
  }

  List<Question> filter(String key) {
    return questions.where((q) => q.subject == key).toList();
  }

  List<GraphData> getYearData(List data) {
    List<GraphData> all = [];

    for (int i = 0; i < data.length; i++) {
      String name = shortMonthNames[data[i].createdAt.month - 1];
      int index = all.indexWhere((e) => e.year == name);
      if (index == -1) {
        all.add(GraphData(name, 1));
      } else {
        all[index].sales++;
      }
    }

    all.sort((a, b) =>
        shortMonthNames.indexOf(a.year) - (shortMonthNames.indexOf(b.year)));

    return all;
  }
}

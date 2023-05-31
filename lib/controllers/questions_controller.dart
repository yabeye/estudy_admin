import 'package:estudy_admin/api/api_provider.dart';
import 'package:estudy_admin/models/question_model.dart';
import 'package:get/get.dart';

class QuestionsController extends GetxController {
  static QuestionsController instance = Get.find();
  var questions = <Question>[].obs;
  final _provider = ApiProvider();

  Future<void> getAllQuestions() async {
    var response = await _provider.get("questions/all");
    var resQuestions = response['data']['questions'];
    clearQuestions();
    List<Question> temp = [];
    for (int i = 0; i < resQuestions.length; i++) {
      temp.add(Question.fromJson(resQuestions[i]));
    }
    questions.value = temp;
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
  }
}

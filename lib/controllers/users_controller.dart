import 'package:estudy_admin/api/api_provider.dart';
import 'package:estudy_admin/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  static UsersController instance = Get.find();
  var users = <User>[].obs;
  var searchKeyWord = "".obs;

  final _provider = ApiProvider();

  // For auth
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> getUsers() async {
    var response = await _provider.get("users");
    var resUsers = response['data']['users'];
    clearAllUsers();
    for (int i = 0; i < resUsers.length; i++) {
      users.add(User.fromJson(resUsers[i]));
    }
    users.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> updateUser({
    required String id,
    required bool isActive,
    List<String>? awards,
  }) async {
    await _provider.patch("users/admin/$id", {
      "isActive": isActive,
      "awards": awards,
    });
    await getUsers();
  }

  Future<void> deleteUser({required String id}) async {
    await _provider.delete("users/$id");
    await getUsers();
  }

  Future<void> deleteQuestion(
      {required String id, required String isActive}) async {
    await _provider.delete("users/$id");
    await getUsers();
  }

  clearAllUsers() {
    users.value = [];
  }
}

import 'dart:convert';

import 'package:estudy_admin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class ApiProvider {
  static String publicUrl = "https://e-study-api.vercel.app/";
  static String baseUrl = "${publicUrl}api/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      String token = usersController.tokenStored.value;
      final completeUri = Uri.parse(baseUrl + url);
      final response = await http.get(completeUri, headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token",
      });

      responseJson = _response(response);
    } on FetchDataException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
    String url,
    Object? body,
  ) async {
    var responseJson;
    try {
      String token = usersController.tokenStored.value;
      final completeUri = Uri.parse(baseUrl + url);
      final response =
          await http.post(completeUri, body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer ${token ?? ""}",
      });
      responseJson = _response(response);
    } on FetchDataException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, Object? body) async {
    var responseJson;
    try {
      String token = usersController.tokenStored.value;
      final completeUri = Uri.parse(baseUrl + url);

      final response =
          await http.patch(completeUri, body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer $token",
      });
      responseJson = _response(response);
    } on FetchDataException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      String token = usersController.tokenStored.value;
      final completeUri = Uri.parse(baseUrl + url);
      final response = await http.delete(completeUri, headers: {
        'Content-Type': 'application/json',
        'authorization': "Bearer ${token ?? ""}",
      });
      responseJson = _response(response);
    } on FetchDataException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    var responseJson = json.decode(response.body.toString());
    // debugPrint("$responseJson");
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        // debugPrint("$responseJson");
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());

        throw BadRequestException(responseJson['error']['message'].toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            responseJson['error']['message'].toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NzZmZmVlZWQ2ZGU5ODZlOWY3M2VlOCIsImlhdCI6MTY4NTUyMDM4OCwiZXhwIjoxNzAzNTIwMzg4fQ.X96BphguY4yfqw63ZFb2ZKy4GIY8eIZSSAR8mVXSsIE";

class ApiProvider {
  static String publicUrl = "http://192.168.89.14:5100/";
  static String baseUrl = "${publicUrl}api/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
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

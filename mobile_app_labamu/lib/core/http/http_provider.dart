import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'throw_exception.dart';

class HttpProvider {
  Future<dynamic> post(String url, dynamic body, {String token = ""}) async {
    dynamic responseJson;

    try {
      final http.Response post = await http.post(
        Uri.parse(url),
        body: body,
        headers: await setHeader(),
      );
      responseJson = response(post);
    } on SocketException {
      throw FetchDataException("No internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request timeout");
    } finally {}
    return responseJson;
  }

  Future<dynamic> get(String url, {String token = ""}) async {
    dynamic responseJson;
    try {
      final http.Response get = await http.get(
        Uri.parse(url),
        headers: await setHeader(),
      );
      responseJson = response(get);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request timeout");
    } finally {}
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body, {String token = ""}) async {
    dynamic responseJson;
    try {
      final http.Response put = await http.put(
        Uri.parse(url),
        body: body,
        headers: await setHeader(),
      );
      responseJson = response(put);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request timeout");
    } finally {}
    return responseJson;
  }

  Future<dynamic> delete(String url, {String token = ""}) async {
    dynamic responseJson;
    try {
      final dynamic delete = await http.delete(
        Uri.parse(url),
        headers: await setHeader(),
      );
      responseJson = response(delete);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on TimeoutException {
      throw RequestTimeoutException("Request timeout");
    } finally {}
    return responseJson;
  }

  Future<Map<String, String>> setHeader() async {
    var token;
    return {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': token ?? "",
    };
  }

  dynamic response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 401:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 404:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 500:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 504:
        final dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      default:
        throw FetchDataException(
          "Error occurred while communication with server. statusCode: ${response.statusCode}",
        );
    }
  }
}

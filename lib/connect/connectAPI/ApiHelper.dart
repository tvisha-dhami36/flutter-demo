import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConnectApi {
  // ignore: constant_identifier_names
  // static const String _BASE_URL = 'https://dummy.restapiexample.com/api/v1/';

  /// POST
  static Future postCallMethod(
    String url, {
    bool customUrl = false,
    Map? body,
    Map<String, String>? headers,
  }) async {
    http.Response? response;
    try {
      debugPrint('postCallMethod');
      if (!customUrl) {
        debugPrint('url:${url}');
      }
      if (customUrl) {
        debugPrint('url:$url');
      }
      if (body != null) debugPrint('body:$body');
      response = await http.post(
        (customUrl) ? Uri.parse(url) : Uri.parse(url),
        headers: headers ??
            {
              'Content-type': 'application/json',
              // if (padQuotes(ConnectHiveSessionData.getToken).isNotEmpty)
              //   'Authorization': 'Bearer ${ConnectHiveSessionData.getToken}',
            },
        body: json.encode(body),
      );
    } on SocketException {
      debugPrint('SocketException');
      return Future.value(null);
    } on HandshakeException {
      debugPrint('HandshakeException');
      return Future.value(null);
    } catch (e) {
      debugPrint('postCallMethod Exception: $e');
      return Future.value(null);
    }
    debugPrint('$url response.statusCode => ${response.statusCode}');
    debugPrint('$url => response.body => ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      return json.decode(response.body);
    }
    return Future.value(null);
  }

  /// GET
  static Future getCallMethod(
    String url, {
    bool customUrl = false,
    bool bodyBytes = false,
    Map<String, String>? headers,
  }) async {
    http.Response? response;
    try {
      debugPrint('getCallMethod');
      if (!customUrl) {
        debugPrint('url:${url}');
      }
      if (customUrl) {
        debugPrint('url:$url');
      }
      response = await http.get(
        (customUrl) ? Uri.parse(url) : Uri.parse(url),
        // headers: headers ??
        //     {
        //       if (padQuotes(ConnectHiveSessionData.getToken).isNotEmpty)
        //         'Authorization': 'Bearer ${ConnectHiveSessionData.getToken}',
        //     },
      );
      print("-----ressssss---$response");
    } on SocketException {
      debugPrint('SocketException');
      return Future.value(null);
    } on HandshakeException {
      debugPrint('HandshakeException');
      return Future.value(null);
    } catch (e) {
      debugPrint('getCallMethod Exception: $e');
      return Future.value(null);
    }
    debugPrint('$url response.statusCode => ${response.statusCode}');
    debugPrint('$url => response.body => ${response.body}');

    if (response.statusCode == 200) {
      if (bodyBytes) {
        return response.bodyBytes;
      } else {
        return json.decode(response.body);
      }
    } else if (response.statusCode == 404) {
      if (bodyBytes) {
        return response.bodyBytes;
      } else {
        return json.decode(response.body);
      }
    }
    return response.body;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'data_repository.dart';

class DataProvider with ChangeNotifier {
  List<DataModel>? data;

  Future<List<DataModel>?> getData() async {
    Response res =
        await http.get(Uri.parse('https://api.github.com/orgs/octokit/repos'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      data = body
          .map(
            (item) => DataModel.fromJson(item),
          )
          .toList();
      return data;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}

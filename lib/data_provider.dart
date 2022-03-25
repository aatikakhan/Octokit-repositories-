import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'data_repository.dart';

class DataProvider with ChangeNotifier {
  List<DataModel>? data;

  Future<List<DataModel>?> getData() async {
   
    // please add username and password for doing basic auth based request
    Response res = await http.get(
      Uri.parse('https://api.github.com/orgs/octokit/repos'),
      headers: <String, String>{
        'authorization':
            'Basic ' + base64Encode(utf8.encode('username:password'))
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      data = [];
    //  add random data to list
      data = body.map((item) => DataModel.fromJson(item)).toList();
    } else {
      throw "Unable to retrieve data. ${res.body}";
    }
  }
}

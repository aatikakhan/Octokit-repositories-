import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_repository.dart';

class DataProvider with ChangeNotifier {
  List<DataModel>? data;

  Future<List<DataModel>?> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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

      sharedPreferences.setString('repository_data', jsonEncode(body));

      // Read the data, decode it and store it in map structure
      List<dynamic> jsondata =
          jsonDecode(sharedPreferences.getString('repository_data')!);
      //convert it into required object
      for (var value in jsondata) {
        DataModel prefsData = DataModel.fromJson(value);
        data!.add(prefsData);
      }
    } else {
      throw "Unable to retrieve data. ${res.body}";
    }
  }
}

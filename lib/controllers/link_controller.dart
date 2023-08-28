// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/models/auth_model.dart';
import 'package:tt9_betweener_challenge/models/link_model.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

Future<List<LinkModel>> getLinks(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  UserModel user = userModelFromJson(prefs.getString('user')!);
  final response = await http.get(
    Uri.parse('https://betweener.gsgtt.tech/api/links'),
    headers: {"Authorization": "Bearer ${user.token}"},
  );
  if (response.statusCode == 200) {
    print('done');
    final jsonbody = jsonDecode(response.body)['links'] as List;
    print(jsonbody);
    return jsonbody.map((e) => LinkModel.fromJson(e)).toList();
  } else if (response.statusCode == 401) {
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, LoginView.id);
  }
  return Future.error('error in get link');
}

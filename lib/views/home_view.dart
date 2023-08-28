import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/models/auth_model.dart';
import 'package:tt9_betweener_challenge/models/link_model.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<UserModel> user;
  late Future<List<LinkModel>> links;
  @override
  void initState() {
    user = getUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Welcome ${snapshot.data?.user?.name}');
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder(
          future: links,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 80),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      height: 50,
                      color: Colors.red,
                      child: Text('${snapshot.data?[index].title}'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 5,
                    );
                  },
                  itemCount: snapshot.data!.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}

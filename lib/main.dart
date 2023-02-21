import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constands.dart';

void main() {
  runApp(MyApp());
}

class User {
  final int id;
  final String name;
  final String email;
  final String username;
  User(
      {required this.username,
      required this.id,
      required this.name,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
    );
  }
}

Future<User> fetchUser() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Integration Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Integration Demo'),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UserName : ${snapshot.data?.username}',
                      style: kstyle,
                    ),
                    Text(
                      'Name : ${snapshot.data?.name}',
                      style: kstyle,
                    ),
                    Text(
                      'Email : ${snapshot.data?.email}',
                      style: kstyle,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

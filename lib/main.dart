import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jellow/pages/index_page.dart';
import 'package:flutter_jellow/pages/moments_page.dart';
import 'package:flutter_jellow/request/login_interceptor.dart';
import 'package:flutter_jellow/request/requests.dart';

void main() {
  dio.interceptors
    ..add(LoginInterceptor())
    ..add(LogInterceptor(requestBody: true, responseBody: true));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Color(0XFFB2B2B2),
      ),
      routes: {
        "/": (_) => IndexPage(),
        "/moments": (_) => MomentsPage(),
      },
      initialRoute: "/",
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Color(0xFF010002)),
        child: Column(
          children: <Widget>[_header(), MomentsPage()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.lightBlue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                size: 30,
              ),
              title: Text(
                '动态',
                style: TextStyle(fontSize: 14),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              size: 30,
            ),
            title: Text(
              '广场',
              style: TextStyle(fontSize: 14),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text(
                '我的',
                style: TextStyle(fontSize: 14),
              )),
        ],
      ),
    );
  }

  Container _header() {
    return Container(
      height: 90,
      padding: EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '动态广场',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

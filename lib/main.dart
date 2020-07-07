import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/model/User.dart';
import 'package:lojavirtual/screens/home/home.dart';
import 'package:lojavirtual/service/auth.dart';
import 'package:lojavirtual/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {
          '/sobre': (context) => Sobre(),
          '/api': (context) => APIScreen(),
        },
        title: "Loja Virtual",
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lojavirtual/model/User.dart';
import 'package:lojavirtual/screens/authenticate/authenticate.dart';
import 'package:lojavirtual/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
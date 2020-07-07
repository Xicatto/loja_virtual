import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/service/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blue[700]],
          ))),
          Container(
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 60, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      child: Image.asset(
                    'assets/imagens/LojaVirtual.png',
                    scale: 2,
                  )),
                  Container(
                    child: Card(
                      elevation: 3,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(32),
                              alignment: Alignment.centerLeft,
                              child: Text('Login',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: TextFormField(
                                validator: (value) =>
                                    value.isEmpty ? "Enter an email" : null,
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                onChanged: (value) {
                                  setState(() => email = value);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: TextFormField(
                                validator: (value) => value.length < 6
                                    ? "Enter a password 6+ long"
                                    : null,
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                onChanged: (value) {
                                  setState(() => password = value);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  OutlineButton(
                                    borderSide: BorderSide(color: Colors.blue),
                                    textColor: Colors.blue,
                                    child: Text('SIGN UP'),
                                    onPressed: () async {
                                      try {
                                        if (_formKey.currentState.validate()) {
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  email, password);
                                        }
                                      } on PlatformException catch (e) {
                                        setState(() => error = e.message);
                                      }
                                    },
                                  ),
                                  RaisedButton(
                                    color: Colors.blue,
                                    elevation: 3,
                                    textColor: Colors.white,
                                    child: Text('LOGIN'),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() =>
                                              error = 'Usuário não encontrado');
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                error,
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

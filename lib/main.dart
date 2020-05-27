import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtual/fonte.dart';
import 'package:lojavirtual/gabinete.dart';
import 'package:lojavirtual/hard_disk.dart';
import 'package:lojavirtual/placa_mae.dart';
import 'package:lojavirtual/placa_video.dart';
import 'package:lojavirtual/ram.dart';
import 'gabineteJson.dart';
import 'menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: "Loja Virtual",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/loja': (context) => SecondScreen(),
        '/sobre': (context) => Sobre(),
        '/carrinho': (context) => Carrinho(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: () {},
                              child: Text('Forgot Password?',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                OutlineButton(
                                  borderSide: BorderSide(
                                    color: Colors.blue
                                  ),
                                  textColor: Colors.blue,
                                  child: Text('SIGN UP'),
                                  onPressed: () {},
                                ),
                                RaisedButton(
                                  color: Colors.blue,
                                  elevation: 3,
                                  textColor: Colors.white,
                                  child: Text('LOGIN'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/loja');
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
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

class _SecondScreenState extends State<SecondScreen> {
  Future<List<GabineteJson>> gabinetes;
  final tabs = [
    'Gabinete',
    'Placa-Mãe',
    'Memória RAM',
    'Placa de Video',
    'HD e SSD',
    'Fonte'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gabinetes = fetchGabinete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              for (final tab in tabs)
                Tab(
                  text: tab,
                )
            ],
          ),
          title: Text('Monte seu PC'),
          actions: <Widget>[
            PopupMenuButton<String>(
                onSelected: sobreAction,
                itemBuilder: (context) {
                  return Menu.escolhas.map((String escolha) {
                    return PopupMenuItem<String>(
                      value: escolha,
                      child: Text(escolha),
                    );
                  }).toList();
                }),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Gabinete(),
            PlacaMae(),
            Ram(),
            PlacaDeVideo(),
            HardDisk(),
            Fonte(),
          ],
        ),
      ),
    );
  }

  void sobreAction(String escolha) {
    if (escolha == Menu.SOBRE) {
      Navigator.pushNamed(context, '/sobre');
    }
  }
}

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Sobre')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      final snackBar = SnackBar(
                        content: Text('Alex'),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/imagens/dev_1.jpg'),
                      maxRadius: 50.0,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/imagens/dev_2.jpeg'),
                    maxRadius: 50.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Desenvolvedores'),
                subtitle: Text('Alex Di Vennet Xicatto'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.announcement),
                title: Text('Tema'),
                subtitle: Text('Loja Virtual'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.flag),
                title: Text('Objetivo'),
                subtitle: Text(
                    'A LV é uma loja virtual especializada em peças de computadores '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Carrinho extends StatelessWidget {

  showAlertDialog(BuildContext context) {

    Widget simBotao = FlatButton(
      child: Text('SIM'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget naoBotao = FlatButton(
      child: Text('NAO'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text("Confirmação"),
      content: Text("Deseja confirmar o seu pedido?"),
      actions: [
        simBotao,
        naoBotao,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              showAlertDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/imagens/gabinete_1.jpg'),
                    title: Text('Gabinete Gamer C3 Tech'),
                    subtitle: Text('Quantidade: 1x'),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/imagens/placa_mae_1.jpg'),
                    title: Text('Placa Mae Razer 3XDR'),
                    subtitle: Text('Quantidade: 1x'),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/imagens/ram_1.jpg'),
                    title: Text('HyperX Furry 16GB'),
                    subtitle: Text('Quantidade: 1x'),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/imagens/placa_de_video_1.jpg'),
                    title: Text('Geforce 1060Ti'),
                    subtitle: Text('Quantidade: 1x'),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/imagens/ssd_1.jpg'),
                    title: Text('SSD Kingston 500GB'),
                    subtitle: Text('Quantidade: 1x'),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/imagens/fonte_1.jpg'),
                    title: Text('Fonte 500W'),
                    subtitle: Text('Quantidade: 1x'),
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                showAlertDialog(context);
              },
              color: Colors.blue,
              child: Text('COMPRAR'),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

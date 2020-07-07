import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/menu.dart';
import 'package:lojavirtual/fonte_widget.dart';
import 'package:lojavirtual/gabinete_widget.dart';
import 'package:lojavirtual/hard_disk_widget.dart';
import 'package:lojavirtual/placa_mae_widget.dart';
import 'package:lojavirtual/placa_de_video_widget.dart';
import 'package:lojavirtual/processador_widget.dart';
import 'package:lojavirtual/memoria_ram_widget.dart';
import 'package:lojavirtual/service/auth.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Github>> fetchAPI() async {
  List<Github> pecas;
  final response = await http.get('https://xicatto.github.io/pecas.json');

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var rest = data["gabinete"] as List;
    pecas = rest.map<Github>((json) => Github.fromJson(json)).toList();
    return pecas;
  } else {
    throw Exception('Falha ao carregar as pecas');
  }
}

class Github {
  final String descricao;
  final String imagem;
  final String preco;

  Github({this.descricao, this.imagem, this.preco});

  factory Github.fromJson(Map<String, dynamic> json) {
    return Github(
      descricao: json['descricao'],
      imagem: json['imagem'],
      preco: json['preco'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();

  final tabs = [
    'Gabinete',
    'Placa-Mãe',
    'Processador',
    'Memória RAM',
    'Placa de Video',
    'HD e SSD',
    'Fonte'
  ];

  @override
  Widget build(BuildContext context) {
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
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            GabineteWidget(),
            PlacaMaeWidget(),
            ProcessadorWidget(),
            MemoriaRamWidget(),
            PlacaDeVideoWidget(),
            HardDiskWidget(),
            FonteWidget(),
          ],
        ),
      ),
    );
  }

  void sobreAction(String escolha) async {
    if (escolha == Menu.SOBRE) {
      Navigator.pushNamed(context, '/sobre');
    } else if (escolha == Menu.DESLOGAR) {
      await _auth.signOut();
    } else if (escolha == Menu.API) {
      Navigator.pushNamed(context, '/api');
    }
  }
}

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      backgroundImage: AssetImage('assets/imagens/Alex.jpg'),
                      maxRadius: 50.0,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/imagens/luana.jpeg'),
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

class APIScreen extends StatefulWidget {
  @override
  APIState createState() => APIState();
}

class APIState extends State<APIScreen> {
  Future<List<Github>> pecasFuture;

  @override
  void initState() {
    super.initState();
    pecasFuture = fetchAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: Center(
        child: FutureBuilder<List<Github>>(
          future: pecasFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Github> pecas = snapshot.data ?? [];
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: pecas.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image.network(
                            pecas.elementAt(index).imagem,
                            fit: BoxFit.contain,
                            width: 150,
                          ),
                          Text(pecas.elementAt(index).descricao),
                          Text(pecas.elementAt(index).preco),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.hasError}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StreamBuilderWidget extends StatefulWidget {

  final String collection;

  StreamBuilderWidget({@required this.collection});

  StreamBuilderState createState() => StreamBuilderState();
}

class StreamBuilderState extends State<StreamBuilderWidget> with AutomaticKeepAliveClientMixin<StreamBuilderWidget> {
  
  String selectedItem = '0';

  List<Map<String, dynamic>> _carrinho = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(widget.collection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return new Text('Erro: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Carregando...');
          default:
            return new ListView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              children: snapshot.data.documents.map((document) {
                return GestureDetector(
                  onTap: () {
                    
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(document['imagem']),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 8.0),
                                    child: Text(
                                      document['nome'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  Text(
                                    "R\$${document['preco'].toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}

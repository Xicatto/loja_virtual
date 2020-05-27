import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gabinete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.all(8),
          children: <Widget>[
            GestureDetector(
              onTap: () {
                final snackBar = SnackBar(content: Text('Gabinete'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset('assets/imagens/gabinete_1.jpg'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final snackBar = SnackBar(content: Text('Gabinete'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset('assets/imagens/gabinete_2.jpg'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final snackBar = SnackBar(content: Text('Gabinete'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset('assets/imagens/gabinete_1.jpg'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final snackBar = SnackBar(content: Text('Gabinete'));
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset('assets/imagens/gabinete_2.jpg'),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/carrinho');
            },
            color: Colors.blue,
            child: Text('CONFIRMAR'),
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

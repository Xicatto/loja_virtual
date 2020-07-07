import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/model/stream_builder.dart';

class PlacaDeVideoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilderWidget(collection: 'placa-de-video');
  }
}
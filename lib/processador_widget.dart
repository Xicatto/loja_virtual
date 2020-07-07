import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/model/stream_builder.dart';

class ProcessadorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilderWidget(collection: 'processador');
  }
}
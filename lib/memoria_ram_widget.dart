import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/model/stream_builder.dart';

class MemoriaRamWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilderWidget(collection: 'memoria-ram');
  }
}

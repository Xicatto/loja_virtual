import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<GabineteJson>> fetchGabinete() async {
  List<GabineteJson> gabinetes;
  final response = await http.get('https://xicatto.github.io/json_file.json');

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var rest = data["gabinete"] as List;
    gabinetes = rest.map<GabineteJson>((json) => GabineteJson.fromJson(json)).toList();
    return gabinetes;
  } else {
    throw Exception('Failed to load gabinetes');
  }
}

class GabineteJson {
  final String descricao;
  final String imagem;
  final String preco;

  GabineteJson({this.descricao, this.imagem, this.preco});

  factory GabineteJson.fromJson(Map<String, dynamic> json) {
    return GabineteJson(
      descricao: json['descricao'],
      imagem: json['imagem'],
      preco: json['preco']
    );
  }
}
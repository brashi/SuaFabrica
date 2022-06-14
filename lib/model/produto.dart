import 'package:flutter/material.dart';

class Produto extends ChangeNotifier {
  final String id;
  final String nome;
  final String imagemArquivo;
  final String descricao;

  final double largura;
  final double comprimento;
  final double altura;

  Produto(
      {required this.id,
      required this.nome,
      required this.imagemArquivo,
      required this.descricao,
      required this.comprimento,
      required this.largura,
      required this.altura});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
        id: json['id'],
        nome: json['nome'],
        imagemArquivo: json['imagem'],
        descricao: json['descricao'],
        comprimento: json['comprimento'],
        largura: json['largura'],
        altura: json['altura']);
  }
}

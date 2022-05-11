import 'package:flutter/material.dart';

class Produto {
  final int id;
  final String nome;
  final Image imagem;
  final String descricao;

  final double largura;
  final double comprimento;
  final double altura;

  Produto(
      {required this.id,
      required this.nome,
      required this.imagem,
      required this.descricao,
      required this.comprimento,
      required this.largura,
      required this.altura});
}

import 'package:flutter/cupertino.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:intl/intl.dart';

class Pedido extends ChangeNotifier {
  final String id;
  final Produto produto;
  final DateTime dataPedido;
  final DateTime dataPrevisao;
  bool pedidoConcluido;

  final NumberFormat format = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final double valor;

  Pedido(
      {required this.id,
      required this.produto,
      required this.dataPedido,
      required this.dataPrevisao,
      this.pedidoConcluido = false,
      required this.valor});

  void togglePedido() {
    this.pedidoConcluido = !this.pedidoConcluido;
    notifyListeners();
  }

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
        id: json['id'],
        produto: Produto.fromJson(json['produto']),
        dataPedido: DateTime.parse(json['dataPedido']),
        dataPrevisao: DateTime.parse(json['dataPrevisao']),
        pedidoConcluido: json['pedidoConcluido'],
        valor: json['valor']);
  }
}

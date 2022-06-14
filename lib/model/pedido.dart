import 'package:flutter/cupertino.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:intl/intl.dart';

class Pedido extends ChangeNotifier {
  final String id;
  final String produtoId;
  final DateTime dataPedido;
  final DateTime dataPrevisao;

  final NumberFormat format = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final double valor;

  Pedido(
      {required this.id,
      required this.produtoId,
      required this.dataPedido,
      required this.dataPrevisao,
      required this.valor});

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
        id: json['id'],
        produtoId: json['produtoId'],
        dataPedido: DateTime.parse(json['dataPedido']),
        dataPrevisao: DateTime.parse(json['dataPrevisao']),
        valor: json['valor']);
  }
}

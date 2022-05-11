import 'package:suafabrica/model/produto.dart';
import 'package:intl/intl.dart';

class Pedido {
  final int id;
  final Produto produto;
  final DateTime dataPedido;
  final DateTime dataPrevisao;

  final NumberFormat format = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final double valor;

  Pedido(
      {required this.id,
      required this.produto,
      required this.dataPedido,
      required this.dataPrevisao,
      required this.valor});
}

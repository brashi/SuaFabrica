import 'package:flutter/material.dart';
import 'package:suafabrica/model/pedido.dart';

class PedidosOpcoesScreen extends StatelessWidget {
  List<Pedido> listaPedidos;
  PedidosOpcoesScreen(this.listaPedidos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: listaPedidos.isEmpty
            ? const Center(
                child: Text("Nenhum pedido ativo."),
              )
            : Text("Tarefa"));
  }
}

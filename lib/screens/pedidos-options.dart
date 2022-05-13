import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suafabrica/data/objetos.dart';
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
            : Container(
                height: 300,
                child: ListView.builder(
                  itemCount: listaPedidos.length,
                  itemBuilder: (context, index) {
                    final pedido = listaPedidos[index];
                    return Card(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detalhes(pedido)));
                            },
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text("Pedido Nº: " +
                                      pedido.id.toString() +
                                      " - " +
                                      pedido.produto.nome +
                                      " - Data entrega: " +
                                      DateFormat('d MMM y : H:m:s')
                                          .format(pedido.dataPrevisao)),
                                )
                              ],
                            )));
                  },
                ),
              ));
  }
}

class Detalhes extends StatelessWidget {
  final Pedido _pedido;
  const Detalhes(this._pedido, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                "Detalhes do pedido: ${_pedido.id} - ${_pedido.produto.nome}")),
        body: Center(
            child: Column(children: <Widget>[
          Card(child: Text("Observações: " + _pedido.produto.descricao)),
          Card(
              child: Text("Data Criação: " +
                  DateFormat('d MMM y : H:m:s').format(_pedido.dataPedido))),
          Card(
              child: Text("Data de entrega prevista: " +
                  DateFormat('d MMM y : H:m:s').format(_pedido.dataPrevisao))),
          Card(
            child: Text("Valor do pedido: " + _pedido.valor.toString()),
          )
        ])));
  }
}

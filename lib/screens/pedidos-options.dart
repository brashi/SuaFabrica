import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/controller/pedido-controller.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:suafabrica/data/objetos.dart';
import 'package:suafabrica/model/pedido.dart';
import 'package:suafabrica/model/produto.dart';

class PedidosOpcoesScreen extends StatelessWidget {
  PedidosOpcoesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtoController = Provider.of<ProdutoController>(context);
    final pedidoController = Provider.of<PedidoController>(context);
    final Future<List<Pedido>> futurePedidos = pedidoController.fetchPedidos();

    final listaProdutos =
        produtoController.produtos.map((e) => Produto.fromJson(e)).toList();

    return FutureBuilder<List<Pedido>>(
        future: futurePedidos,
        builder: (context, lista) {
          if (lista.hasError) {
            return const Center(
                child: const Text("Erro ao carregar conteúdo..."));
          } else if (lista.hasData) {
            return lista.data!.isEmpty
                ? const Center(
                    child: Text("Nenhum pedido ativo."),
                  )
                : Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: lista.data?.length,
                      itemBuilder: (context, index) {
                        final pedido = lista.data![index];
                        final produtoDoPedido = listaProdutos
                            .firstWhere((e) => e.id == pedido.produtoId);
                        return Card(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detalhes(
                                              pedido,
                                              produtoDoPedido.nome,
                                              produtoDoPedido.descricao)));
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text("Pedido Nº: " +
                                          pedido.id.toString() +
                                          " - " +
                                          produtoDoPedido.nome +
                                          " - Data entrega: " +
                                          DateFormat('d MMM y : H:m:s')
                                              .format(pedido.dataPrevisao)),
                                    )
                                  ],
                                )));
                      },
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class Detalhes extends StatelessWidget {
  final Pedido _pedido;
  final nomeProduto;
  final descricaoProduto;
  const Detalhes(this._pedido, this.nomeProduto, this.descricaoProduto,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Detalhes do pedido: ${_pedido.id} - ${nomeProduto}")),
        body: Center(
            child: Column(children: <Widget>[
          Card(child: Text("Observações: " + descricaoProduto)),
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

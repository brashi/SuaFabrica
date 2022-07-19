import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/controller/pedido-controller.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:suafabrica/model/pedido.dart';
import 'package:suafabrica/model/produto.dart';

class ProdutoDetalhes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pedidoController = Provider.of<PedidoController>(context);

    final produto = ModalRoute.of(context)?.settings.arguments as Produto;
    return Scaffold(
      appBar: AppBar(
        title: Text(produto.nome),
      ),
      body: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: Image.network(produto.imagemArquivo).image,
                    fit: BoxFit.fill,
                  ),
                ),
                Flexible(
                  child: Column(children: <Widget>[
                    Text("Nome da peça: " + produto.nome),
                    Text("Descrição: " + produto.descricao),
                    Text("Medidas (Altura x Comprimento x Largura): \n" +
                        produto.altura.toString() +
                        "cm x " +
                        produto.comprimento.toString() +
                        "cm x " +
                        produto.largura.toString() +
                        "cm ."),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pedidoController.addPedido(Pedido(
                            id: Random().nextDouble().toString(),
                            produto: (produto),
                            dataPedido: DateTime.now(),
                            dataPrevisao: (DateTime.now()
                                .add(Duration(hours: Random().nextInt(120)))),
                            valor: produto.altura *
                                (produto.comprimento + produto.largura)));
                        Navigator.of(context).pop(produto.nome);
                      },
                      child: Text("Comprar"),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suafabrica/data/objetos.dart';
import 'package:suafabrica/model/pedido.dart';
import 'package:suafabrica/model/produto.dart';

class ProdutoDetalhes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final produto = ModalRoute.of(context)?.settings.arguments as Produto;
    return Scaffold(
        appBar: AppBar(
          title: Text(produto.nome),
        ),
        body: Card(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(
                    image: produto.imagem.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(children: <Widget>[
                  Text("Nome da peça: " + produto.nome),
                  Text("Descrição: " + produto.descricao),
                  Text("Medidas (Altura x Comprimento x Largura): " +
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
                      PEDIDOS.add(Pedido(
                          id: Random().nextInt(9999),
                          produto: (produto),
                          dataPedido: DateTime.now(),
                          dataPrevisao: (DateTime.now()
                              .add(Duration(hours: Random().nextInt(59)))),
                          valor: produto.altura *
                              (produto.comprimento + produto.largura)));
                      Navigator.of(context).pop(produto.nome);
                    },
                    child: Text("Comprar"),
                  )
                ]),
              ])
            ],
          ),
        ));
  }
}

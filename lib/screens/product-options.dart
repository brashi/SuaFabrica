import 'package:flutter/material.dart';
import 'package:suafabrica/components/produto-item.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:suafabrica/data/objetos.dart';

class ProdutoOpcoesScreen extends StatelessWidget {
  const ProdutoOpcoesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: PRODUTOS.map((produto) {
            return ProdutoItem(produto);
          }).toList()),
    );
  }
}

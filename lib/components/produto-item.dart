import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suafabrica/model/produto.dart';

class ProdutoItem extends StatelessWidget {
  final Produto produto;
  const ProdutoItem(this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
            padding: const EdgeInsets.all(15), child: produto.imagem));
  }
}

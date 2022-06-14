import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:suafabrica/utils/app_routes.dart';

class ProdutoItem extends StatelessWidget {
  final Produto produto;
  const ProdutoItem(this.produto);

  _selecionarProduto(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AppRoutes.PRODUCT_DETAILS, arguments: produto);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _selecionarProduto(context),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image(
                        image: Image.file(File(produto.imagemArquivo)).image,
                        width: double.infinity,
                        fit: BoxFit.fill)),
                Positioned(
                  right: 15,
                  bottom: 20,
                  child: Container(
                      color: Colors.black54,
                      child: Text(
                        produto.nome,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        softWrap: true, //quebra de lina
                        overflow: TextOverflow.fade, //case de overflow
                      )),
                )
              ],
            )));
  }
}

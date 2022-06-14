import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:suafabrica/utils/app_routes.dart';

class ProdutoManage extends StatelessWidget {
  const ProdutoManage({Key? key}) : super(key: key);

  _deletarProduto(Produto produto, ProdutoController lista) {
    lista.removeProduto(produto);
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Produto>(context);
    final productListProv = Provider.of<ProdutoController>(context);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Row(children: <Widget>[
        Flexible(child: Text(product.id + "  -  " + product.nome)),
        Flexible(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          const Text('Deseja realmente deletar o produto ?'),
                      action: SnackBarAction(
                          label: 'Sim',
                          onPressed: () =>
                              _deletarProduto(product, productListProv))));
                },
                child: Icon(Icons.cancel),
              )),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.ADD, arguments: product);
                },
                child: const Icon(Icons.change_circle)),
          ),
        )
      ]),
    );
  }
}

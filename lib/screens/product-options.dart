import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/components/produto-item.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:suafabrica/data/objetos.dart';

class ProdutoOpcoesScreen extends StatelessWidget {
  const ProdutoOpcoesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoController>(context);
    final Future<List<Produto>> futureProdutos = provider.fetchProdutos();
    return FutureBuilder<List<Produto>>(
      future: futureProdutos,
      builder: (context, lista) {
        if (lista.hasError) {
          return const Center(
              child: const Text("Erro ao carregar conteúdo..."));
        } else if (lista.hasData) {
          return GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: lista.data!.map((produto) {
                return ProdutoItem(produto);
              }).toList());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

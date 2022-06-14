import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/components/produto-manage.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:suafabrica/model/produto.dart';

class ProdutoManageScreen extends StatelessWidget {
  const ProdutoManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProdutoController>(context);
    final Future<List<Produto>> futureProdutos = provider.fetchProdutos();

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<List<Produto>>(
        future: futureProdutos,
        builder: (context, lista) {
          if (lista.hasError) {
            return const Center(
                child: Text("Erro ao carregar lista de produtos."));
          } else if (lista.hasData) {
            return ListView.builder(
                itemCount: lista.data?.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                      value: lista.data![index],
                      child: ProdutoManage(),
                    ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

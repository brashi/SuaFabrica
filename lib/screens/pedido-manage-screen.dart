import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/components/pedido-manage.dart';
import 'package:suafabrica/controller/pedido-controller.dart';
import 'package:suafabrica/model/pedido.dart';

class PedidoManageScreen extends StatelessWidget {
  const PedidoManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PedidoController>(context);
    final Future<List<Pedido>> futurePedidos = provider.fetchPedidos();

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<List<Pedido>>(
          future: futurePedidos,
          builder: (context, lista) {
            if (lista.hasError) {
              return const Center(
                  child: Text("Erro ao carregar lista de pedidos."));
            } else if (lista.hasData) {
              return ListView.builder(
                  itemCount: lista.data?.length,
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                        value: lista.data![index],
                        child: PedidoManage(),
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/controller/pedido-controller.dart';
import 'package:suafabrica/model/pedido.dart';
import 'package:suafabrica/utils/app_routes.dart';

class PedidoManage extends StatelessWidget {
  const PedidoManage({Key? key}) : super(key: key);

  _deletarPedido(Pedido pedido, PedidoController lista) {
    lista.removePedido(pedido);
  }

  @override
  Widget build(BuildContext context) {
    final pedido = Provider.of<Pedido>(context);
    final pedidoController = Provider.of<PedidoController>(context);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Row(children: <Widget>[
        Flexible(
          child: Text(pedido.id + "  -  " + pedido.produto.nome),
        ),
        Flexible(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          const Text('Deseja realmente deletar o pedido ?'),
                      action: SnackBarAction(
                        label: 'Sim',
                        onPressed: () =>
                            _deletarPedido(pedido, pedidoController),
                      ),
                    ),
                  );
                },
                child: Icon(Icons.cancel),
              )),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: pedido.pedidoConcluido
                    ? Colors.red
                    : Colors.green.shade400),
            onPressed: () {
              pedido.togglePedido();
              pedidoController.updatePedido(pedido);
            },
            child: pedido.pedidoConcluido
                ? Row(children: [
                    const Text('Reverter confirmação'),
                    Icon(Icons.cancel)
                  ])
                : Row(children: [
                    const Text('Confirmar Pedido'),
                    Icon(Icons.done)
                  ]),
          ),
        ))
      ]),
    );
  }
}

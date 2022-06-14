import 'dart:convert';
import 'dart:math';

import 'package:suafabrica/controller/produto-controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:suafabrica/model/pedido.dart';

class PedidoController with ChangeNotifier {
  final _baseURL = 'https://suafabrica-72ebb-default-rtdb.firebaseio.com';
  late Map<String, dynamic> mapaPedidos;

  List<dynamic> get produtos {
    return [...mapaPedidos.values];
  }

  Future<List<Pedido>> fetchPedidos() async {
    final response = await http.get(Uri.parse('$_baseURL/pedidos.json'));

    if (response.statusCode == 200) {
      List<Pedido> lista = [];
      final dados = jsonDecode(response.body) as Map<String, dynamic>;

      mapaPedidos = dados;
      dados.forEach((key, value) {
        lista.add(Pedido.fromJson(dados[key]));
      });

      return lista;
    } else {
      throw Exception('Erro ao carregar pedidos pelo serviço web.');
    }
  }

  // Future<void> savePedido(Map<String, Object> data) {
  //   bool hasId = data['id'] != null;

  //   final produto = Pedido(
  //     id: hasId ? data['id'] as String : Random().nextDouble().toString(),
  //     nome: data['nome'] as String,
  //     imagemArquivo: data['imagem'] as String,
  //     descricao: data['descricao'] as String,
  //     comprimento: data['comprimento'] as double,
  //     largura: data['largura'] as double,
  //     altura: data['altura'] as double,
  //   );

  //   if (hasId) {
  //     return updateProduto(produto);
  //   } else {
  //     return addProduto(produto);
  //   }
  // }

  Future<void> addPedido(Pedido pedido) {
    final future = http.post(Uri.parse('$_baseURL/pedidos.json'),
        body: jsonEncode({
          "id": pedido.id,
          "produtoId": pedido.produtoId,
          "dataPedido": pedido.dataPedido.toUtc().toString(),
          "dataPrevisao": pedido.dataPrevisao.toUtc().toString(),
          "valor": pedido.valor
        }));

    return future.then((response) {
      print(jsonDecode(response.body));
      print(response.statusCode);

      notifyListeners();
    });
  }

  Future<void> updatePedido(Pedido pedido) async {
    fetchPedidos();
    var chavePedido;
    mapaPedidos.forEach((key, value) {
      Map<String, dynamic> map = mapaPedidos[key];
      if (pedido.id.toString() == map['id']) {
        chavePedido = key;
      }
    });
    print(chavePedido);

    final response =
        await http.put(Uri.parse('${_baseURL}/pedidos/${chavePedido}.json'),
            headers: <String, String>{
              'Content-Type': 'application/json; chartset=UTF-8',
            },
            body: jsonEncode({
              'id': pedido.id,
              'produtoId': pedido.produtoId,
              'dataPedido': pedido.dataPedido,
              'dataPrevisao': pedido.dataPrevisao,
              'valor': pedido.valor
            }));

    notifyListeners();
  }

  Future<Pedido> removePedido(Pedido pedido) async {
    fetchPedidos();
    var chavePedido;
    mapaPedidos.forEach((key, value) {
      Map<String, dynamic> map = mapaPedidos[key];
      if (pedido.id == map['id']) {
        chavePedido = key;
      }
    });
    print(chavePedido);

    final http.Response response = await http.delete(
      Uri.parse('${_baseURL}/pedidos/${chavePedido}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
      return Pedido.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao remover pedido');
    }
  }
}

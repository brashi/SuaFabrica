import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoController with ChangeNotifier {
  final _baseURL = 'https://suafabrica-72ebb-default-rtdb.firebaseio.com';
  late Map<String, dynamic> mapaProdutos;

  List<dynamic> get produtos {
    return [...mapaProdutos.values];
  }

  // static carregarMapa() async {
  //   final response = await http.get(Uri.parse(
  //       'https://suafabrica-72ebb-default-rtdb.firebaseio.com/produtos.json'));
  //   if (response.statusCode == 200) {
  //     final dados = jsonDecode(response.body) as Map<String, dynamic>;
  //   }
  // }

  Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(Uri.parse('$_baseURL/produtos.json'));

    if (response.statusCode == 200) {
      List<Produto> lista = [];
      final dados = jsonDecode(response.body) as Map<String, dynamic>;

      mapaProdutos = dados;
      dados.forEach((key, value) {
        lista.add(Produto.fromJson(dados[key]));
      });

      return lista;
    } else {
      throw Exception('Erro ao carregar produtos pelo serviço web.');
    }
  }

  Future<void> saveProduto(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final produto = Produto(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      nome: data['nome'] as String,
      imagemArquivo: data['imagem'] as String,
      descricao: data['descricao'] as String,
      comprimento: data['comprimento'] as double,
      largura: data['largura'] as double,
      altura: data['altura'] as double,
    );

    if (hasId) {
      return updateProduto(produto);
    } else {
      return addProduto(produto);
    }
  }

  Future<void> addProduto(Produto produto) {
    final future = http.post(Uri.parse('$_baseURL/produtos.json'),
        body: jsonEncode({
          "id": produto.id,
          "nome": produto.nome,
          "imagem": produto.imagemArquivo,
          "descricao": produto.descricao,
          "comprimento": produto.comprimento,
          "largura": produto.largura,
          "altura": produto.altura
        }));

    return future.then((response) {
      print(jsonDecode(response.body));
      print(response.statusCode);

      notifyListeners();
    });
  }

  Future<void> updateProduto(Produto produto) async {
    fetchProdutos();
    var chaveProduto;
    mapaProdutos.forEach((key, value) {
      Map<String, dynamic> map = mapaProdutos[key];
      if (produto.id.toString() == map['id']) {
        chaveProduto = key;
      }
    });
    print(chaveProduto);

    final response =
        await http.put(Uri.parse('${_baseURL}/produtos/${chaveProduto}.json'),
            headers: <String, String>{
              'Content-Type': 'application/json; chartset=UTF-8',
            },
            body: jsonEncode({
              'id': produto.id,
              'nome': produto.nome,
              'imagem': produto.imagemArquivo,
              'descricao': produto.descricao,
              'comprimento': produto.comprimento,
              'largura': produto.largura,
              'altura': produto.altura
            }));

    notifyListeners();
  }

  Future<Produto> removeProduto(Produto produto) async {
    fetchProdutos();
    var chaveProduto;
    mapaProdutos.forEach((key, value) {
      Map<String, dynamic> map = mapaProdutos[key];
      if (produto.id == map['id']) {
        chaveProduto = key;
      }
    });
    print(chaveProduto);

    final http.Response response = await http.delete(
      Uri.parse('${_baseURL}/produtos/${chaveProduto}.json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
      return Produto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao remover produto');
    }
  }
}

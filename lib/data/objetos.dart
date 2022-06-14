import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suafabrica/model/pedido.dart';
import 'package:suafabrica/model/produto.dart';

List<Pedido> PEDIDOS = [];

List<Produto> PRODUTOS = [
  Produto(
      id: Random().nextDouble().toString(),
      nome: 'Engrenagem',
      descricao: 'Engrenagem com paço de 6,8cm.',
      altura: 10,
      comprimento: 15,
      imagemArquivo: 'lib/assets/engrenagem.jpg',
      largura: 5),
  Produto(
      id: Random().nextDouble().toString(),
      nome: 'Juntas',
      descricao: 'juntas diversas para prototipagem',
      altura: 5,
      comprimento: 15,
      imagemArquivo: 'lib/assets/juntas.jpg',
      largura: 5),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Dobradiça',
    descricao: 'Dobradiças de protitopo para portas',
    altura: 5,
    comprimento: 10,
    largura: 3,
    imagemArquivo: 'lib/assets/dobradica.jpg',
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Mola P',
    descricao: 'Mola pequena',
    altura: 1.234,
    comprimento: 1.54,
    largura: 1.12,
    imagemArquivo: 'lib/assets/mola.png',
  )
];

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suafabrica/model/pedido.dart';
import 'package:suafabrica/model/produto.dart';

List<Pedido> PEDIDOS = [];

List<Produto> PRODUTOS = [
  Produto(
      id: Random().nextInt(9999),
      nome: 'Engrenagem',
      descricao: 'Engrenagem com paço de 6,8cm.',
      altura: 10,
      comprimento: 15,
      imagem: Image.file(File('lib/assets/engrenagem.jpg')),
      largura: 5),
  Produto(
      id: Random().nextInt(9999),
      nome: 'Juntas',
      descricao: 'juntas diversas para prototipagem',
      altura: 5,
      comprimento: 15,
      imagem: Image.file(File('lib/assets/juntas.jpg')),
      largura: 5),
  Produto(
      id: Random().nextInt(9999),
      nome: 'Dobradiça',
      descricao: 'Dobradiças de protitopo para portas',
      altura: 5,
      comprimento: 10,
      largura: 3,
      imagem: Image.file(
        File('lib/assets/dobradica.jpg'),
      )),
  Produto(
      id: Random().nextInt(9999),
      nome: 'Mola P',
      descricao: 'Mola pequena',
      altura: 1.234,
      comprimento: 1.54,
      largura: 1.12,
      imagem: Image.file(File('lib/assets/mola.png'))),
];

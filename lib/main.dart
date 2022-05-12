import 'package:flutter/material.dart';
import 'package:suafabrica/components/produto-detalhes.dart';
import 'package:suafabrica/screens/home_page.dart';
import 'package:suafabrica/screens/product-options.dart';
import 'package:suafabrica/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sua Fábrica' + const Icon(Icons.settings).toString(),
      theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.orange.shade400,
              secondary: Colors.amber.shade200)),
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (context) => HomePage(),
        AppRoutes.PRODUCT_OPTIONS: (context) => ProdutoOpcoesScreen(),
        AppRoutes.PRODUCT_DETAILS: (context) => ProdutoDetalhes(),
      },
    );
  }
}

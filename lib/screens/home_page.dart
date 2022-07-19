import 'package:flutter/material.dart';
import 'package:suafabrica/components/main-drawer.dart';
import 'package:suafabrica/screens/pedidos-options.dart';
import 'package:suafabrica/screens/product-options.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexSelectedScreen = 0;

  List<Widget> _screens = [ProdutoOpcoesScreen(), PedidosOpcoesScreen()];
  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sua Fábrica ⚙️")),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          currentIndex: _indexSelectedScreen,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart), label: 'Comprar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_headline), label: 'Pedidos'),
          ]),
      drawer: MainDrawer(),
    );
  }
}

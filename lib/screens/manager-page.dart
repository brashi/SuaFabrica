import 'package:flutter/material.dart';
import 'package:suafabrica/components/main-drawer.dart';
import 'package:suafabrica/screens/pedido-manage.dart';
import 'package:suafabrica/screens/produto-manage-screen.dart';
import 'package:suafabrica/utils/app_routes.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  int _indexSelectedScreen = 0;

  List<Widget> _screens = [PedidoManageScreen(), ProdutoManageScreen()];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Área do Fabricante"), actions: [
        if (_indexSelectedScreen == 1)
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.ADD);
            },
            tooltip: 'Adicionar Produto...',
            icon: const Icon(Icons.add),
          ),
      ]),
      body: _screens[_indexSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _indexSelectedScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Ver pedidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Ver produtos'),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}

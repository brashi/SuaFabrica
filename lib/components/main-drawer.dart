import 'package:suafabrica/core/services/auth/auth_service.dart';
import 'package:suafabrica/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _createItem(IconData icon, String label, Function() onTap) {
      var cor = Colors.grey;
      if (label == "Deslogar-se") {
        cor = Colors.red;
      }
      return ListTile(
        leading: Icon(
          icon,
          size: 26,
          color: cor,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      );
    }

    return Drawer(
      child: Column(
        children: [
          _createItem(Icons.home, 'Painel do Cliente',
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)),
          _createItem(
              Icons.settings,
              'Painel do Fabricante',
              () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.MANAGE)),
          _createItem(Icons.exit_to_app_outlined, 'Deslogar-se', () {
            AuthService().logout();
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          })
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suafabrica/components/produto-detalhes.dart';
import 'package:suafabrica/controller/pedido-controller.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:suafabrica/core/services/notification/chat_notification_service.dart';
import 'package:suafabrica/model/produto.dart';
import 'package:suafabrica/screens/auth_or_app_page.dart';
import 'package:suafabrica/screens/auth_page.dart';
import 'package:suafabrica/screens/home_page.dart';
import 'package:suafabrica/screens/manager-page.dart';
import 'package:suafabrica/screens/product-options.dart';
import 'package:suafabrica/screens/produto-form.dart';
import 'package:suafabrica/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PedidoController()),
        ChangeNotifierProvider(create: (context) => ProdutoController()),
        ChangeNotifierProvider(create: (context) => ChatNotificationService())
      ],
      child: MaterialApp(
        title: 'Sua Fábrica' + const Icon(Icons.settings).toString(),
        theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                primary: Colors.orange.shade400,
                secondary: Colors.amber.shade200)),
        initialRoute: '/',
        routes: {
          AppRoutes.HOME: (context) => AuthOrAppPage(),
          AppRoutes.AUTH: (context) => AuthPage(),
          AppRoutes.ADD: (context) => ProductFormPage(),
          AppRoutes.MANAGE: (context) => ManagePage(),
          AppRoutes.PRODUCT_OPTIONS: (context) => ProdutoOpcoesScreen(),
          AppRoutes.PRODUCT_DETAILS: (context) => ProdutoDetalhes(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

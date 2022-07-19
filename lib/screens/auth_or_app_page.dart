import 'package:suafabrica/core/services/notification/chat_notification_service.dart';
import 'package:suafabrica/model/com_user.dart';
import 'package:suafabrica/core/services/auth/auth_service.dart';
import 'package:suafabrica/screens/auth_page.dart';
import 'package:suafabrica/screens/home_page.dart';
import 'package:suafabrica/screens/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  /* APP FIREBASE */
  Future<void> init(BuildContext context) async {
    try {
      await Firebase.initializeApp();
      await Provider.of<ChatNotificationService>(
        context,
        listen: false,
      ).init();
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder<ComUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                return snapshot.hasData ? const HomePage() : const AuthPage();
              }
            },
          );
        }
      },
    );
  }
}

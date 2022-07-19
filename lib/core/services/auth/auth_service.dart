import 'dart:io';

import 'package:suafabrica/core/services/auth/auth_firebase_service.dart';
import 'package:suafabrica/core/services/auth/auth_mock_service.dart';
import 'package:suafabrica/core/services/auth/auth_service.dart';
import 'package:suafabrica/model/com_user.dart';

//Poderia usar o ChaangeNotificer?
//Provider par amonitorar as mudanças? SIM
abstract class AuthService {
  //métodos abstratos

  ComUser? get currentUser; //opcional

  //sequencia de dados (lança mudança quando alguma mudnaça sobre o usuário acontecer)
  Stream<ComUser?> get userChanges; //opcional

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();

  //Retorna uma implementação a partir da classe mais genérica
  factory AuthService() {
    //return AuthMockService();
    return AuthFirebaseService();
  }
}

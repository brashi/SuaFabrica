import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:suafabrica/model/com_user.dart';
import 'package:suafabrica/core/services/auth/auth_service.dart';

//Simula o serviço de autenticação
class AuthMockService implements AuthService {
  static final _defaultUser = ComUser(
    id: '456',
    name: 'User',
    email: 'user@email.com',
    imageURL: 'assets/images/avatar.png',
  );

  //static - associado a classe e não a instancia
  //varias instancias de AuthMockService - Mesma lista de usuários
  //varias instancias de AuthMockService - Mesmo usuário
  static Map<String, ComUser> _users = {
    _defaultUser.email: _defaultUser,
  };

  static ComUser? _currentUser;

  static MultiStreamController<ComUser?>? _controller;

  //stream - lidando com usuários
  //Stream - valores gerados por demanda - iteração na aplicação
  // - não logado: usuario nulo
  // - logado: usuario valido
  // - logoff: nulo
  static final _userStream = Stream<ComUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  ComUser? get currentUser {
    return _currentUser;
  }

  Stream<ComUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ComUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ComUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}

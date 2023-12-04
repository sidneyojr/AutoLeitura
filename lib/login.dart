import 'dart:convert';
import 'package:autoleitura/leitura.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

var apiUrl =
    'http://env-2733645.jelastic.saveincloud.net/usuarios/listar_usuarios.php';

class User {
  final int id;
  final String local;
  final String nome;
  final String celular;
  final String email;

  User(this.id, this.local, this.nome, this.celular, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['local'],
      json['nome'],
      json['celular'],
      json['email'],
    );
  }
}

class UserModel extends Model {
  late User _currentUser;

  User get currentUser => _currentUser;

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}

class LoginModel extends Model {
  late UserModel _userModel;

  UserModel get userModel => _userModel;

  LoginModel(UserModel userModel) {
    _userModel = userModel;
  }

  Future<User?> fetchUserByCode(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?id=$id'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('code') && data['code'] == 1) {
          List<dynamic> users = data['result'];

          if (users.isNotEmpty) {
            Map<String, dynamic>? userData = users.firstWhere(
              (user) => user['id'] == id,
              orElse: () => null,
            );
            if (userData != null) {
              User user = User.fromJson(userData);
              _userModel.setCurrentUser(user);
              return user;
            }
          } else {
            throw Exception('Usuário não encontrado');
          }
        } else {
          throw Exception('Resposta da API não possui o código esperado');
        }
      } else {
        throw Exception('Erro ao obter usuário: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro ao obter usuário: $error');
    }
    return null;
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final codigoUsuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoginModel>(
      model: LoginModel(UserModel()),
      child: ScopedModelDescendant<LoginModel>(
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
            title: const Text('AUTO LEITURA - LOGIN'),
            backgroundColor: const Color.fromARGB(255, 0, 5, 8),
            centerTitle: true,
          ),
          backgroundColor: Color.fromARGB(255, 217, 230, 247),
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Coloque seu código aqui',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: codigoUsuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Código Único de Usuário',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Material(
                    color: Color.fromARGB(255, 15, 76, 129), // Azul mais claro
                    borderRadius: BorderRadius.circular(20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () async {
                        String idString = codigoUsuarioController.text;

                        try {
                          int id = int.parse(idString);
                          User? user = await model.fetchUserByCode(id);

                          if (user != null) {
                            _mostrarDialog(
                              context,
                              'Código válido. Nome: ${user.nome}',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Leitura(
                                      userId: user.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            _mostrarDialog(context, 'Usuário não encontrado');
                          }
                        } catch (error) {
                          print('Erro ao validar código: $error');
                          _mostrarDialog(context, 'Código inválido');
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          'Enviar para Validação',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _mostrarDialog(BuildContext context, String mensagem,
    [VoidCallback? onPressed]) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Resultado da Validação'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onPressed != null) {
                onPressed();
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void main() {
  runApp(const MaterialApp(
    home: Login(),
  ));
}

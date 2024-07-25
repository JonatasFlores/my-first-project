import 'package:alura_flutter_curso_1/screens/initial_screen.dart';
import 'package:alura_flutter_curso_1/screens/user_list.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 32),
              _buildTextField(
                emailController,
                'E-mail',
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Vazio';
                  } else {
                    if (!value.contains('@') || !value.contains('.com')) {
                      return 'E-mail Inválido';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              _buildTextField(
                passwordController,
                'Senha',
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Vazio';
                  } else {
                    if (value.length < 3) {
                      return 'Senha Pequena';
                    }
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (users.any(
                        (element) =>
                            element.email == emailController.text &&
                            element.password == passwordController.text,
                      )) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => InitialScreen()),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Inválido')));
                      }
                      ;
                    }
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(
    TextEditingController controller,
    String label,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

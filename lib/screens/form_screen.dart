import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'New Task',
          ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 3,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Isira um nome';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nome',
                          fillColor: Colors.white70,
                          filled: true,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.parse(value) > 5 ||
                              int.parse(value) < 1) {
                            return 'Isira uma dificuldade entre 1 e 5';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dificuldade',
                          fillColor: Colors.white70,
                          filled: true,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Adicione uma URL');
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Imagem',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageController.text,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Container();
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Botão Elevado (ElevatedButton) com ação assíncrona ao ser pressionado (onPressed)
                  ElevatedButton(
                    onPressed: () async {
                      // Verifica se o estado atual do formulário é válido
                      if (_formKey.currentState!.validate()) {
                        // Obtém a URL da imagem do controlador de texto
                        final imageUrl = imageController.text;

                        // Faz uma requisição HTTP HEAD para verificar os cabeçalhos da URL fornecida
                        final response = await http.head(Uri.parse(imageUrl));

                        // Verifica se o status da resposta é 200 (OK) e se o cabeçalho 'content-type' começa com 'image/'
                        if (response.statusCode == 200 &&
                            response.headers['content-type']
                                    ?.startsWith('image/') ==
                                true) {
                          // Se a URL refere-se a uma imagem válida, imprime os valores dos controladores de texto no console
                          print(nameController.text); // Imprime o nome
                          print(difficultyController
                              .text); // Imprime a dificuldade
                          print(
                              imageController.text); // Imprime a URL da imagem

                          // Exibe uma mensagem de sucesso usando um SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tarefa Adicionada Com Sucesso'),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          // Se a URL não é válida, exibe uma mensagem de erro usando um SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('URL da imagem inválida'),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Adicionar'), // Texto do botão
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

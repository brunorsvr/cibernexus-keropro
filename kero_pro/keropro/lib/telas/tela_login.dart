import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaLogin extends StatefulWidget{
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _fazerLogin() async {
    String emailDigitado = _emailController.text;
    String senhaDigitada = _senhaController.text;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailDigitado,
        password: senhaDigitada,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso! 🚀'),
          backgroundColor: Colors.green,
        ),
      );

      // (No futuro, aqui o app pulará para a Tela Principal do encanador/pintor)

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha incorretos!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('KeroPro', style: TextStyle(fontSize: 40,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40,),
              TextField(controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,),
              SizedBox(height: 24,),
              TextField(controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha',
                    border: OutlineInputBorder()),
                obscureText: true,),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: _fazerLogin, child: Text('Entrar')),
              TextButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaCadastro())
              );}, child: const Text("Ainda não tem conta? Cadastre-se"),)
            ],)
        ,),
    );
  }
}
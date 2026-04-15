import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keropro/telas/tela_clientes.dart';
import 'package:keropro/telas/tela_profissional.dart';

class TelaLogin extends StatefulWidget{
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _fazerLogin() async {
    String emailDigitado = _emailController.text.trim();
    String senhaDigitada = _senhaController.text.trim();

    try {
      UserCredential credencial = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailDigitado,
        password: senhaDigitada,
      );

      DocumentSnapshot documento = await FirebaseFirestore.instance
          .collection('usuarios').doc(credencial.user!.uid).get();

      if (documento.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso! 🚀'),
            backgroundColor: Colors.green,
          ),
        );

        String tipoUsuario = documento['tipoUsuario'];

        if (tipoUsuario == 'cliente') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaClientes()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TelaProfissional()));
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Perfil de usuário incompleto no banco de dados.')),
        );
      }

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
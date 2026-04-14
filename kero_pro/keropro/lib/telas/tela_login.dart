import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_cadastro.dart';

class TelaLogin extends StatelessWidget{
  const TelaLogin({super.key});

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
              TextField(decoration: InputDecoration(labelText: 'E-mail:',
                  border: OutlineInputBorder()),),
              SizedBox(height: 24,),
              TextField(obscureText: true, 
              decoration: InputDecoration(labelText: 'Senha:',
              border: OutlineInputBorder()),),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: () {}, child: Text('Entrar')),
              TextButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaCadastro())
              );}, child: const Text("Ainda não tem conta? Cadastre-se"),)
            ],)
        ,),
    );
  }
}
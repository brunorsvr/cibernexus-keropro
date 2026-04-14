import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaCadastro extends StatefulWidget{
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  Future<void> _cadastrarusuario() async{
    String emailDigitado = _emailController.text;
    String senhaDigitada = _senhaController.text;
    String confirmaSenha = _confirmaSenhaController.text;

    if (senhaDigitada != confirmaSenha){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("As senhas não são iguais!"),
          backgroundColor: Colors.red,)
      );
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailDigitado,
        password: senhaDigitada,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta criada com sucesso! 🎉'),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erro ao criar conta. Verifique os dados.'),
              backgroundColor: Colors.red,
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Criar Conta')
      ,),
      body: Padding(padding: EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            TextField(controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome',
                border: OutlineInputBorder()),),
            SizedBox(height: 16),
            TextField(controller: _emailController,
            decoration: InputDecoration(labelText: 'E-mail',
                border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,),
            SizedBox(height: 16,),
            TextField(controller: _senhaController,
            decoration: InputDecoration(labelText: 'Senha',
                border: OutlineInputBorder()),
                obscureText: true,),
            SizedBox(height: 16,),
            TextField(controller:_confirmaSenhaController,
              decoration: InputDecoration(labelText: 'Confirme a Senha',
                border: OutlineInputBorder()),
                obscureText: true,),
            SizedBox(height: 32,),
            ElevatedButton(onPressed: _cadastrarusuario,
                child: Text('Cadastrar'))
          ],
        ),
      ),),
      );
  }
}
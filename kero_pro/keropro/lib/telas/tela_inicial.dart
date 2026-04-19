import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_clientes.dart';
import 'package:keropro/telas/tela_profissional.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Tela de testes"),),
    body: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TelaClientes() ));
      }, child: Text("Cliente!")),
      ElevatedButton(onPressed: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TelaProfissional()));
      }, child: Text("Profissional"))

    ],));
  }
}

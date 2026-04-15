import 'package:flutter/material.dart';

class TelaClientes extends StatelessWidget {
  const TelaClientes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do Cliente')),
      body: const Center(
        child: Text('Bem-vindo! Tela de clientes em construção 🚧'),
      ),
    );
  }
}
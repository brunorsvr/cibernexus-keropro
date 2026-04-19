import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaClientes extends StatefulWidget {
  const TelaClientes({super.key});

  @override
  State<TelaClientes> createState() => _TelaClientesState();
}

class _TelaClientesState extends State<TelaClientes> {
  final _tituloController = TextEditingController();
  double _valorTaxa = 15.00;
  double _distanciaKm = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pedir um Profissional")),
      body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.00, vertical: 20.00),
          child: Column(children: [
            TextField(controller: _tituloController,
              decoration: InputDecoration(labelText: "Qual o problema?"),),
            SizedBox(height: 24),
            Text("Distância: ${_distanciaKm.toInt()} km"),
            Slider(min: 1.0, max: 50.0,
                value: _distanciaKm,
                onChanged: (novoValor){
                    setState(() {
                      _distanciaKm = novoValor;
                      _valorTaxa = 5.00 * (_distanciaKm *1.50);
                    });
                }),
            Text("Valor: R\$ ${_valorTaxa.toStringAsFixed(2)}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 50,
              child: ElevatedButton(onPressed: (){
                String clienteLogado = "Pedro Simoes";
                Map<String, String> novoPedido = {
                  "titulo": _tituloController.text,
                  "cliente": clienteLogado,
                  "valor": "R\$ ${_valorTaxa.toStringAsFixed(2)}",
                  "status": "pendente"
                };
                FirebaseFirestore.instance
                    .collection("servicos")
                    .add(novoPedido)
                    .then((value){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pedido de ajuda enviado!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                });
                Navigator.pop(context);
              },
                  child: Text("Pedir Ajuda!")),
            ),
            SizedBox(height: 16),
            Text("Aviso: O valor do conserto será negociado diretamente com o profissional no local.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepOrange),
            )
          ],),
      )
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaClientes extends StatefulWidget {
  const TelaClientes({super.key});

  @override
  State<TelaClientes> createState() => _TelaClientesState();
}

class _TelaClientesState extends State<TelaClientes> {
  final _tituloController = TextEditingController();
  double _valorTaxa = 0;
  double _distanciaKm = 0;
  final double latBase = -23.5015;
  final double lonBase = -47.4581;
  double? _latCliente;
  double? _lonCliente;

  Future<void> _pedirPermissaoGPS() async{
    bool servicoAtivado = await Geolocator.isLocationServiceEnabled();
    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied){
      permissao = await Geolocator.requestPermission();
    }
    Position posicaoAtual = await Geolocator.getCurrentPosition();
    double distanciaEmMetros = Geolocator.distanceBetween(latBase, lonBase, posicaoAtual.latitude, posicaoAtual.longitude);
    setState(() {
      _distanciaKm = distanciaEmMetros / 1000;
      _valorTaxa = 5.00 + (_distanciaKm * 1.5);
      _latCliente = posicaoAtual.latitude;
      _lonCliente = posicaoAtual.longitude;
    });
  }
  @override
  void initState() {
    super.initState();
    _pedirPermissaoGPS();
  }

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
            Text("Valor: R\$ ${_valorTaxa.toStringAsFixed(2)}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 50,
              child: ElevatedButton(onPressed: () async{
               // final String idUsuarioLogado = FirebaseAuth.instance.currentUser!.uid;
                final String idUsuarioLogado = "cliente_teste_001";
                Map<String, dynamic> novoPedido = {
                  "titulo": _tituloController.text,
                  "cliente": "Pedro Simoes",
                  "clienteId": idUsuarioLogado,
                  "valor": "R\$ ${_valorTaxa.toStringAsFixed(2)}",
                  "status": "pendente",
                  "latitude": _latCliente,
                  "longitude": _lonCliente
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
                  Navigator.pop(context);
                }
                );
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
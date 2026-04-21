import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaDetalhesServico extends StatelessWidget{
  const TelaDetalhesServico({super.key, required this.tiluloServico, required this.clienteServico, required this.precoServico,required this.idServico, required this.latCliente, required this.lonCliente});
  final String tiluloServico;
  final String clienteServico;
  final String precoServico;
  final String idServico;
  final double latCliente;
  final double lonCliente;


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Detalhes do Servico'),),
      body: Column(
        children: [
          Expanded(child:
            FlutterMap(options: MapOptions(
              initialCenter: LatLng(latCliente, lonCliente),
              initialZoom: 16.0,
            ), children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.seunome.keropro',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(latCliente, lonCliente),
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ],
            )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(tiluloServico,
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              SizedBox(height: 8),
              Text(clienteServico, style: TextStyle(fontSize: 22),),
              SizedBox(height: 8),
              Text(precoServico,
                style: TextStyle(fontSize: 22,color: Colors.green, fontWeight: FontWeight.bold),),
              SizedBox(height: 18),
                ElevatedButton.icon(onPressed: (){
                  final String linkDoMapa = "https://www.google.com/maps/search/?api=1&query=$latCliente,$lonCliente";
                  final Uri url = Uri.parse(linkDoMapa);
                  launchUrl(url, mode: LaunchMode.externalApplication);
                },
                    icon:Icon(Icons.map), label: Text("Ver Rota no Mapa")),
                SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      // final String idUsuarioLogado = FirebaseAuth.instance.currentUser!.uid ;
                      final String idUsuarioLogado = "profissional_teste_002";
                      FirebaseFirestore.instance
                          .collection("servicos")
                          .doc(idServico)
                          .update({"status": "aceito", "profissionalID": idUsuarioLogado});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Serviço aceito! O cliente será notificado.'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Aceitar Serviço",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            ],)
            ,)
        ],
      ),

    );
  }

}
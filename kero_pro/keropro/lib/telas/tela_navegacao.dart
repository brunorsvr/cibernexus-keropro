import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TelaNavegacao extends StatefulWidget{
  const TelaNavegacao({super.key, required this.latCliente, required this.lonCliente});
  final double latCliente;
  final double lonCliente;
  @override
  State<TelaNavegacao> createState() => _TelaNavegacaoState();
}

class _TelaNavegacaoState extends State<TelaNavegacao> {
  LatLng? minhaPosicao;

  Future<void> _pegarPosicao() async{
    Position posicaoGPS = await Geolocator.getCurrentPosition();
    setState(() {
      minhaPosicao = LatLng(posicaoGPS.latitude, posicaoGPS.longitude);
    });

  }
  @override
  void initState(){
    super.initState();
    _pegarPosicao();
  }

  @override
  Widget build(BuildContext context) {
    if(minhaPosicao == null){
      return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
    }
    return Scaffold(
      appBar: AppBar(title: const Text("A Caminho do Cliente")),
      body: FlutterMap(options: MapOptions(initialCenter: minhaPosicao!,
      initialZoom: 16.00),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.seunome.keropro',
        ),
        PolylineLayer(polylines: [Polyline(strokeWidth: 5.0, color: Colors.blue, points:
        [minhaPosicao!, LatLng(widget.latCliente, widget.lonCliente)])
        ]),
        MarkerLayer(markers: [Marker(
            point: minhaPosicao!,
            child: const Icon(Icons.directions_car, color: Colors.blue, size: 40)),
        Marker(
            point: LatLng(widget.latCliente, widget.lonCliente),
            child: const Icon(Icons.location_on, color: Colors.red, size: 40))])
      ],)
    );
  }
}


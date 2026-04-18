import 'package:flutter/material.dart';

class TelaDetalhesServico extends StatelessWidget{
  const TelaDetalhesServico({super.key, required this.tiluloServico, required this.clienteServico, required this.precoServico});
  final String tiluloServico;
  final String clienteServico;
  final String precoServico;



  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Detalhes do Servico'),),
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.blueGrey,)),
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
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_navegacao.dart';

class TelaMeusServicos extends StatefulWidget{
  const TelaMeusServicos({super.key});

  @override
  State<TelaMeusServicos> createState() => _TelaMeusServicosState();
}

class _TelaMeusServicosState extends State<TelaMeusServicos> {
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("Meus Servicos"),),
    body: StreamBuilder(stream: FirebaseFirestore.instance
        .collection("servicos")
        .where("profissionalID", isEqualTo: "profissional_teste_002")
        .where("status", isEqualTo: "aceito")
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Ocorreu um erro!"),);
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text("Voce ainda nao aceitou nenhum servico"));
          }
          var listaServicosAceitos = snapshot.data!.docs;
          return ListView.builder(itemCount: listaServicosAceitos.length,
              itemBuilder: (context, index) {
                return Card(elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.plumbing),
                    title: Text(
                        listaServicosAceitos[index]["titulo"] ?? "Servico sem nome"),
                    subtitle: Text('Cliente: ${listaServicosAceitos[index]["cliente"] ??
                        "Cliente sem nome"}'
                        '\nValor Estimado: ${listaServicosAceitos[index]["valor"]}'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaNavegacao(
                        latCliente: listaServicosAceitos[index]["latitude"],
                        lonCliente: listaServicosAceitos[index]["longitude"]
                      )));
                    },
                  ),
                );
              }
          );
        }
        )
    );
  }
}
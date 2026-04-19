import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_detalhes_servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TelaProfissional extends StatefulWidget {
  const TelaProfissional({super.key});

  @override
  State<TelaProfissional> createState() => _TelaProfissionalState();
}

class _TelaProfissionalState extends State<TelaProfissional> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do Profissional'), backgroundColor: Colors.blue,),
      body: StreamBuilder(stream: FirebaseFirestore.instance
          .collection("servicos")
          .where("status", isEqualTo: "pendente" )
          .snapshots(),
          builder: (context, snapshot){
                if (snapshot.hasError){
                  return Text("Erro ao carregar servicos.");
                }
                if (snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                final listaPedidos = snapshot.data!.docs;
                return ListView.builder(itemCount: listaPedidos.length,
                    itemBuilder: (context, index){
                      return  Card(elevation: 5,
                        child: ListTile(
                          leading: Icon(Icons.plumbing),
                          title: Text(listaPedidos[index]["titulo"] ?? "Servico sem nome"),
                          subtitle: Text('Cliente: ${listaPedidos[index]["cliente"] ?? "Cliente sem nome"}'
                              '\nValor Estimado: ${listaPedidos[index]["valor"]}'),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  TelaDetalhesServico(
                                  tiluloServico: listaPedidos[index]["titulo"] ?? "Servico sem nome",
                                  clienteServico: listaPedidos[index]["cliente"] ?? "Cliente sem nome",
                                  precoServico: listaPedidos[index]["valor"] ?? "R\$ 0.00",
                                  idServico: listaPedidos[index].id,
                              ),
                            )
                            );
                          },
                        ),
                      );
                    });
          } )
    );
  }
}


/*
*  Card(elevation: 5,
        child: ListTile(
          leading: Icon(Icons.plumbing),
          title: Text('Vazamento na pia'),
          subtitle: Text('Cliente: Joao - Centro\nValor Estimado: R\$100,00'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const TelaDetalhesServico(
                  tiluloServico: 'Troca de Resistencia',
                  clienteServico: 'Dona Maria',
                  precoServico: '40.00',),)
            );
          },
          ),
        ),
        * ListView.builder(itemCount: meusServicos.length,
          itemBuilder: (context, index){
        return  Card(elevation: 5,
          child: ListTile(
            leading: Icon(Icons.plumbing),
            title: Text(meusServicos[index]["titulo"] ?? "Servico sem nome"),
            subtitle: Text('Cliente: ${meusServicos[index]["cliente"] ?? "Cliente sem nome"}'
                '\nValor Estimado: ${meusServicos[index]["valor"]}'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>  TelaDetalhesServico(
                  tiluloServico: meusServicos[index]["titulo"] ?? "Servico sem nome",
                  clienteServico: meusServicos[index]["cliente"] ?? "Cliente sem nome",
                  precoServico: meusServicos[index]["valor"] ?? "R\$ 0.00"
                ),
              )
              );
            },
          ),
        );
          }) */
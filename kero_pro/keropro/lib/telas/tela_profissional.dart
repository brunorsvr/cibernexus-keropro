import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_detalhes_servico.dart';

class TelaProfissional extends StatefulWidget {
  const TelaProfissional({super.key});

  @override
  State<TelaProfissional> createState() => _TelaProfissionalState();
}

class _TelaProfissionalState extends State<TelaProfissional> {
  List<Map<String,String>> meusServicos = [
    {"titulo": "Vazamento", "cliente": "Maria", "valor": "R\$ 100"},
    {"titulo": "Lâmpada", "cliente": "João", "valor": "R\$ 50"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área do Profissional'), backgroundColor: Colors.blue,),
      body: ListView.builder(itemCount: meusServicos.length,
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
          })
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
        ),*/
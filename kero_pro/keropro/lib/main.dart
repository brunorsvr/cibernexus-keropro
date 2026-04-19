import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keropro/telas/tela_inicial.dart';
import 'package:keropro/telas/tela_login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const KeroPro());

}

class KeroPro extends StatelessWidget {
  const KeroPro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeroPro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

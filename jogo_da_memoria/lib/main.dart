import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:jogo_da_memoria/controller/game_controller.dart';
import 'package:jogo_da_memoria/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jogo_da_memoria/repositories/recordes.dart';
import 'package:jogo_da_memoria/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  
  runApp(MultiProvider(
    providers: [
      Provider<RecordesRepository>(
        create: (_) => RecordesRepository(),
      ),
      ProxyProvider<RecordesRepository, GameController>(update: (_, repo, __) => GameController(recordesRepository: repo),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brogo da Memoria',
      debugShowCheckedModeBanner: false,
      theme: BrogoTheme.theme,
      home: const HomePage(),
    );
  }
}

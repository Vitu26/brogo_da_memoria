import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/pages/nivel_page.dart';
import 'package:jogo_da_memoria/theme.dart';
import 'package:jogo_da_memoria/widgets/recordes.dart';
import 'package:jogo_da_memoria/widgets/start_buttom.dart';
import 'package:jogo_da_memoria/constants.dart';

import '../widgets/logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  selecionarNivel(Modo modo, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NivelPage(modo: modo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            StartButton(
              title: 'Modo Normal',
              color: Colors.white,
              action: () => selecionarNivel(Modo.normal, context),
            ),
            StartButton(
              title: 'Modo Brogo',
              color: BrogoTheme.pink,
              action: () => selecionarNivel(Modo.Brogo, context),
            ),
            const SizedBox(height: 60),
            const Recordes(),
          ],
        ),
      ),
    );
  }
}

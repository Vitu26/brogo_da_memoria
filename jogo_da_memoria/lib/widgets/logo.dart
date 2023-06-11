import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/theme.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(bottom: 30),
        child: Image.asset('images/logo.png', width: 80, height: 125,),
        ),
        Padding(padding: const EdgeInsets.only(bottom: 40),
        child: RichText(
          text: TextSpan(
            text: 'Brogo da Memória',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
            // children: const [
            //   TextSpan(
            //     text: 'Opa',
            //     style: TextStyle(color: BrogoTheme.pink)
            //   ),
            // ],
          )),)
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:jogo_da_memoria/constants.dart';
import 'package:jogo_da_memoria/controller/game_controller.dart';
import 'package:jogo_da_memoria/widgets/start_button.dart';
import 'package:provider/provider.dart';

class FeedbackGame extends StatelessWidget {
  final Resultado resultado;

  const FeedbackGame({Key? key, required this.resultado}) : super(key: key);

  String getResultado() {
    return resultado == Resultado.aprovado ? 'aprovado' : 'eliminado';
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GameController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${getResultado().toUpperCase()}!',
            style: const TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset('images/${getResultado()}.png'),
          ),
          resultado == Resultado.eliminado
              ? StartButton(
                  title: 'Tentar novamente',
                  color: Colors.white,
                  action: () => controller.restartGame(),
                )
              : StartButton(
                  title: 'Próximo Nível',
                  color: Colors.white,
                  action: () => controller.nextLevel(),
                ),
        ],
      ),
    );
  }
}


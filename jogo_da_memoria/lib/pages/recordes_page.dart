import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jogo_da_memoria/repositories/recordes.dart';
import 'package:jogo_da_memoria/theme.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RecordesPage extends StatelessWidget {
  final Modo modo;


  const RecordesPage({Key? key, required this.modo}) : super(key: key);

  getModo() {
    return modo == Modo.normal ? 'Normal' : 'Brogo';
  }

    List<Widget> getRecordesList(Map recordes) {
    final List<Widget> widgets = [];

    recordes.forEach((nivel, score) {
      widgets.add(ListTile(
        title: Text('Nível $nivel'),
        trailing: Text(score.toString()),
        tileColor: Colors.grey[900],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ));

      widgets.add(const Divider(color: Colors.transparent));
    });

    if (widgets.isEmpty) {
      widgets.add(
        const Center(
          child: Text('AINDA NÃO RECORDES!'),
        ),
      );
    }

    return widgets;
  }
  

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordesRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Observer(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 24),
                child: Center(
                  child: Text(
                    'Modo ${getModo()}',
                    style: const TextStyle(fontSize: 28, color: BrogoTheme.pink),
                  ),
                ),
                ),
                ...getRecordesList(modo == Modo.normal ? repository.recordesNormal : repository.recordesBrogo),
            ],
          ),
        ),
           
            
      ),
    );
  }
}

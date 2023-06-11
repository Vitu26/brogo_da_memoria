import 'package:jogo_da_memoria/constants.dart';
import 'package:jogo_da_memoria/models/game_play.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'recordes.g.dart';

class RecordesRepository = RecordesRepositoryBase with _$RecordesRepository;

abstract class RecordesRepositoryBase with Store {
  late final Box _recordes;
  late final GamePlay gamePlay;
  @observable
  Map recordesBrogo = {};
  @observable
  Map recordesNormal = {};

  RecordesRepositoryBase() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadRecordes();
  }

  _initDatabase() async {
    _recordes = await Hive.openBox('gameRecordes3');
  }

  @action
  loadRecordes() {
    recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    recordesBrogo = _recordes.get(Modo.Brogo.toString()) ?? {};
  }

  updateRecordes({required GamePlay gamePlay, required int score}) {
    final key = gamePlay.modo.toString();

    if (gamePlay.modo == Modo.normal &&
        (recordesNormal[gamePlay.nivel] == null || score < recordesNormal[gamePlay.nivel])) {
      recordesNormal[gamePlay.nivel] = score;
      _recordes.put(key, recordesNormal);
    } else if (gamePlay.modo == Modo.Brogo &&
        (recordesBrogo[gamePlay.nivel] == null || score > recordesBrogo[gamePlay.nivel])) {
      recordesBrogo[gamePlay.nivel] = score;
      _recordes.put(key, recordesBrogo);
    }
  }
}
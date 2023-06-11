//todas as regras do jogo
import 'package:jogo_da_memoria/game_settings.dart';
import 'package:jogo_da_memoria/models/game_opcao.dart';
import 'package:jogo_da_memoria/models/game_play.dart';
import 'package:jogo_da_memoria/repositories/recordes.dart';
import 'package:mobx/mobx.dart';

import '../constants.dart';

part 'game_controller.g.dart';

class GameController = GameControllerBase with _$GameController;

abstract class GameControllerBase with Store {
  @observable
  List<GameOpcao> gameCards = [];
  @observable
  int score = 0;
  @observable
  bool venceu = false;
  @observable
  bool perdeu = false;

//propriedades do jogo
  late GamePlay _gamePlay;
  List<GameOpcao> _escolha = [];
  List<Function> _escolhaCallback = [];
  int _acertos = 0;
  int _numPares = 0;
  RecordesRepository recordesRepository;

  @computed
  bool get jogadaCompleta => (_escolha.length == 2);

  GameControllerBase({required this.recordesRepository}) {
    reaction((_) => venceu == true, (bool ganhou) {
      if (ganhou) {
        recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score);
      }
    });
  }

  //metodo para iniciar o jogo
  startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _acertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    venceu = false;
    perdeu = false;
    _resetScore();
    _generateCards();
  }

  //reset no score
  _resetScore() {
    _gamePlay.modo == Modo.normal ? score = 0 : score = _gamePlay.nivel;
  }

  _generateCards() {
    List<int> cardOpcoes = GameSettings.cardOpcoes.sublist(0)..shuffle();
    cardOpcoes = cardOpcoes.sublist(0, _numPares);
    gameCards = [...cardOpcoes, ...cardOpcoes]
        .map(
            (opcao) => GameOpcao(opcao: opcao, matched: false, selected: false))
        .toList();
    gameCards.shuffle();
  }

  escolher(GameOpcao opcao, Function resetCard) async {
    opcao.selected = true;
    _escolha.add(opcao);
    _escolhaCallback.add(resetCard);
    await _comparaEscolhas();
  }

  _comparaEscolhas() async {
    if (jogadaCompleta) {
      if (_escolha[0].opcao == _escolha[1].opcao) {
        _acertos++;
        _escolha[0].matched = true;
        _escolha[1].matched = true;
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          for (var i in [0, 1]) {
            _escolha[i].selected = false;
            _escolhaCallback[i]();
          }
        });
      }
      _resetJogada();
      _updateScore();
      _checkGameResult();
    }
  }

  _checkGameResult() async {
    bool allMatched = _acertos == _numPares;
    if (_gamePlay.modo == Modo.normal) {
      await _checkGameResultModoNormal(allMatched);
    } else {
      await _checkGameResultModoBrogo(allMatched);
    }
  }

  _checkGameResultModoNormal(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1), () => venceu = allMatched);
  }

  _checkGameResultModoBrogo(bool allMatched) async {
    if (_chancesAcabaram()) {
      await Future.delayed(
          const Duration(microseconds: 400), () => perdeu = true);
    }
    if (allMatched && score >= 0) {
      await Future.delayed(
          const Duration(seconds: 1), () => venceu = allMatched);
    }
  }

  _chancesAcabaram() {
    return score < _numPares - _acertos;
  }

  _resetJogada() {
    _escolha = [];
    _escolhaCallback = [];
  }

  _updateScore() {
    _gamePlay.modo == Modo.normal ? score++ : score--;
  }

  restartGame() {
    startGame(gamePlay: _gamePlay);
  }

  nextLevel() {
    int nivelIndex = 0;

    if (_gamePlay.nivel != GameSettings.niveis.last) {
      nivelIndex = GameSettings.niveis.indexOf(_gamePlay.nivel) + 1;
    }
    _gamePlay.nivel = GameSettings.niveis[nivelIndex];
    startGame(gamePlay: _gamePlay);
  }
}

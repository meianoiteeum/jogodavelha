import 'package:flutter/material.dart';
import 'package:jogodavelha/service/logic.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  late Player _player1;
  late Player _player2;
  late Logic _logic;
  late int _round;
  late List _displayElement = ['', '', '', '', '', '', '', '', ''];
  late var info;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _logic = Logic();
    _player1 = Player(name: 'p1', symbol: 'X');
    _player2 = Player(name: 'p2', symbol: 'O');
    _round = 0;
  }

  Future<void> _initPackageInfo() async {
    info = await PackageInfo.fromPlatform();
    setStat();
  }

  setStat() {
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Jogo Da Velha"),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return Column(
      children: [header(), bodyGame(), footer()],
    );
  }

  header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                _player1.getName(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                _player1.getScore(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                _player2.getName(),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                _player2.getScore(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  bodyGame() {
    return Expanded(
      flex: 4,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _tapped(index);
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Center(
                child: Text(
                  _displayElement[index],
                  style: const TextStyle(color: Colors.black, fontSize: 35),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  footer() {
    return Text(_packageInfo.version);
  }

  void _tapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          moviment(index, 0, 0);
          break;
        case 1:
          moviment(index, 0, 1);
          break;
        case 2:
          moviment(index, 0, 2);
          break;
        case 3:
          moviment(index, 1, 0);
          break;
        case 4:
          moviment(index, 1, 1);
          break;
        case 5:
          moviment(index, 1, 2);
          break;
        case 6:
          moviment(index, 2, 0);
          break;
        case 7:
          moviment(index, 2, 1);
          break;
        case 8:
          moviment(index, 2, 2);
          break;
      }
    });
  }

  moviment(index, column, row) {
    if (isPlayer1()) {
      logic(index, _player1, column, row);
    } else {
      logic(index, _player2, column, row);
    }
  }

  isPlayer1() {
    return _round % 2 == 0;
  }

  logic(index, Player player, column, row) {
    player.incrementMoves();
    if (_logic.insertMap(player, column, row)) {
      _displayElement[index] = player.getSymbol();
    }
    if (_logic.verifyWin(player, column, row)) {
      _alert('Player $player winner', player);
      return;
    }
    _round++;
    if (_round == 9) {
      _alert('Draw Game', player);
    }
  }

  getVersion() {
    return _packageInfo.version;
  }

  _resetGameWin(Player player) {
    player.incrementScore();
    _player1.setCountMoves(0);
    _player2.setCountMoves(0);
    _resetGame();
  }

  _resetGame({resetAll = false}) {
    _round = 0;
    if(resetAll){
      _player1 = Player(name: _player1.getName(), symbol: _player1.getSymbol());
      _player2 = Player(name: _player2.getName(), symbol: _player2.getSymbol());
    }
    _displayElement = ['', '', '', '', '', '', '', '', ''];
    _logic.clearMap();
    setStat();
  }

  _alert(text, Player player) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Voltar');
                _resetGame(resetAll: true);
              },
              child: const Text('Voltar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Continuer');
                _resetGameWin(player);
              },
              child: const Text('Continuar'),
            )
          ],
        );
      },
    );
  }
}

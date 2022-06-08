import '../model/player.dart';

class Logic{
  final Player player1 = Player(name: 'P1',symbol: 'X');
  final Player player2 = Player(name: 'P2',symbol: 'O');

  getText(){
    return player1.getSymbol();
  }

}
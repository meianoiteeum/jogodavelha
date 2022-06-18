import '../model/player.dart';

class Logic{
   late List<List<Player>> _map = _getMap();

  verifyWin(Player player, column, row){
    if(_verifyCount(player)){
      return _verifyConditionToWin(player);
    }
    return false;
  }

  _verifyConditionToWin(Player player) {
    if(_map[0][0] == player && _verifyMidMap(player) && _map.elementAt(2).elementAt(2) == player){
      return true;
    }
    if(_map.elementAt(0).elementAt(2) == player && _verifyMidMap(player) && _map.elementAt(2).elementAt(0) == player){
      return true;
    }
    if(_verifyHorizontal(player)) {
      return true;
    }
    return _verifyVertical(player);
  }

  _verifyMidMap(Player player) => _map.elementAt(1).elementAt(1) == player;

  _verifyHorizontal(Player player) {
    for(int x = 0; x < _map.length;x++){
      if(_map.elementAt(x).elementAt(0) == player && _map.elementAt(x).elementAt(1) == player && _map.elementAt(x).elementAt(2) == player){
        return true;
      }
    }
    return false;
  }

  _verifyVertical(Player player) {
    for(int y = 0; y < _map.length;y++){
      if(_map.elementAt(0).elementAt(y) == player && _map.elementAt(1).elementAt(y) == player && _map.elementAt(2).elementAt(y) == player){
        return true;
      }
    }
    return false;
  }

  _verifyCount(Player player) {
    return player.getCountMoves() >= 3;
  }

  insertMap(Player player, column, row){
    if(_map[column][row].getSymbol() == ""){
      _map[column][row] = player;
      return true;
    }
    return false;
  }

  clearMap(){
    _map = _getMap();
  }

  _getMap(){
    return List.generate(3, (i) {
      return List.generate(3, (j){
        return Player(name: "", symbol: "");
      });
    });
  }
}

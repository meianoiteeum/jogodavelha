class Player {
  late String _name;
  late String _symbol;
  late int _countMoves;

  Player({required name, required symbol}){
    _name = name;
    _symbol = symbol;
  }

  getName(){
    return _name;
  }

  setName(String name){
    _name = name;
  }

  getSymbol(){
    return _symbol;
  }

  setSymbol(String symbol){
    _symbol = symbol;
  }

  getCountMoves(){
    return _countMoves;
  }

  setCountMoves(int countMoves){
    _countMoves = countMoves;
  }

  incrementMoves(){
    _countMoves++;
  }
}
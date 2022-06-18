class Player {
  late String _name;
  late String _symbol;
  late int _countMoves;
  late int _score = 0;

  Player({required name, required symbol}){
    _name = name;
    _symbol = symbol;
    _countMoves = 0;
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

  getCountMoves() => _countMoves;

  setCountMoves(int countMoves){
    _countMoves = countMoves;
  }

  getScore() => _score.toString();

  incrementMoves(){
    _countMoves++;
  }

  incrementScore(){
    _score++;
  }

  @override
  String toString(){
    return _name;
  }
}
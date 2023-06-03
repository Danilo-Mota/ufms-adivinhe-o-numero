import 'dart:math';

import 'package:adivinhe_o_numero/play_view.dart';

class PlayViewModel extends PlayViewProtocol {
  int _currentValue = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _position = 0;

  final List<int> numbersList = [];
  Random random = Random();

  @override
  String get currentValue => _currentValue.toString();

  @override
  String get correctAnswers => _correctAnswers.toString();

  @override
  String get wrongAnswers => _wrongAnswers.toString();

  @override
  void createListOfNumbers() {
    for (int i = 0; i < 10; i++) {
      int randomNumber = random.nextInt(100);
      numbersList.add(randomNumber);
    }
    _currentValue = numbersList[_position];
    notifyListeners();
  }

  @override
  void didTapBigger() {
    if (_position + 1 == 9) {
      onWin?.call();
      return;
    }
    if (numbersList[_position + 1] > _currentValue) {
      _correctAnswers++;
      _currentValue = numbersList[_position + 1];
      notifyListeners();
      _position++;
    } else {
      _wrongAnswers++;
      _currentValue = numbersList[_position + 1];
      notifyListeners();
      _position++;
      if (_wrongAnswers == 3) {
        onLoss?.call();
        return;
      }
    }
  }

  @override
  void didTapSmaller() {
    if (numbersList[_position + 1] < _currentValue) {
      _correctAnswers++;
      _currentValue = numbersList[_position + 1];
      notifyListeners();
      _position++;
    } else {
      _wrongAnswers++;
      _currentValue = numbersList[_position + 1];
      notifyListeners();
      _position++;
      if (_wrongAnswers == 3) {
        onLoss?.call();
        return;
      }
    }
  }

  @override
  void resetGame() {
    _position = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    numbersList.clear();
    createListOfNumbers();
    notifyListeners();
  }
}

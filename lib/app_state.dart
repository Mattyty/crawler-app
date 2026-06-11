import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _currentCity = prefs.getString('ff_currentCity') ?? _currentCity;
    });
    _safeInit(() {
      _userPersona = prefs.getString('ff_userPersona') ?? _userPersona;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _currentCity = 'Manchester';
  String get currentCity => _currentCity;
  set currentCity(String value) {
    _currentCity = value;
    prefs.setString('ff_currentCity', value);
  }

  String _userPersona = 'Student';
  String get userPersona => _userPersona;
  set userPersona(String value) {
    _userPersona = value;
    prefs.setString('ff_userPersona', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

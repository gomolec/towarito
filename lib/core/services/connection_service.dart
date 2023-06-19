import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class ConnectionService {
  final Connectivity _connectivity;

  ConnectionService({
    required Connectivity connectivity,
  }) : _connectivity = connectivity {
    initialize();
  }

  bool _hasConnection = false;

  final _connectionStreamController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> observeConnectionStatus() => _connectionStreamController.stream;

  bool get hasConnection => _hasConnection;

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    final bool previousConnection = _connectionStreamController.value;

    try {
      final url = Uri.https('google.com');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } catch (e) {
      _hasConnection = false;
    }

    if (previousConnection != _hasConnection) {
      _connectionStreamController.add(_hasConnection);
    }
    log("${DateTime.now()} Has connection: $_hasConnection");

    return _hasConnection;
  }

  void dispose() {
    _connectionStreamController.close();
  }
}

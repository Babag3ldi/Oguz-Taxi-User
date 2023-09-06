import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/driver_model.dart';

class SocketService {
  WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('ws://216.250.9.245:81/ws/location'));
  final StreamController<DriverModel> streamController = StreamController<DriverModel>.broadcast();
}

class WebSocketService {
  //final
  WebSocketChannel? _channel;

  // WebSocketService(this.token);

  // Initialize the WebSocket connection
  void initWebSocket(String token) {
    if (_channel != null) return;
    _channel = WebSocketChannel.connect(Uri.parse('ws://216.250.9.245:81/ws/location/?token=$token'));
    //IOWebSocketChannel.connect('ws://216.250.9.245:81/ws/location/?Token=$token');
  }

  // Send a message over the WebSocket
  void sendMessage(String message) {
    if (_channel != null) {
      _channel!.sink.add(message);
    }
  }

  // Listen for incoming messages
  Stream<dynamic> get messages {
    if (_channel != null) {
      return _channel!.stream;
    } else {
      throw Exception('WebSocket channel not initialized.');
    }
  }

  // Close the WebSocket connection
  void closeWebSocket() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }
}

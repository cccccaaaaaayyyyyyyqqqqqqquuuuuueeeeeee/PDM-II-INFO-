import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
Future<void> main() async{
  final socket = await Socket.connect("192.168.68.102", 8080); // o primeiro parâmetro é o ip do servidor e o segundo é a porta.
  // o ip 0.0.0.0 não funciona porque ele é uma representação de qualquer ip, mas o client precisa de um ip específico para se conectar.
  print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');
  
  String? username;

  do {
    print("Client: Digite seu nome");
    username = stdin.readLineSync();
  } while (username == null || username.isEmpty);

  socket.write(username); // manda pro listenner do server.

  void sendTemperature(){
    final temperature = 20 + Random().nextDouble() * 15;
    final String message = "Temperatura atual: ${temperature}°C";

    socket.write(message);
    socket.flush();

    print("Client: $message");
  };

  sendTemperature();

  socket.listen(
    (Uint8List data) async{
      final serverResponse = String.fromCharCodes(data);
      print("Client: $serverResponse");

    },
    onError: (error) {
      print("Client: $error");
    },
    onDone: () {
      print("Client: Conexão encerrada");
      socket.destroy();
    }
  );
}
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'dart:async';
Future<void> main() async{
  final socket = await Socket.connect("localhost", 8080); // o primeiro parâmetro é o ip do servidor e o segundo é a porta.
  // o ip 0.0.0.0 não funciona porque ele é uma representação de qualquer ip, mas o client precisa de um ip específico para se conectar.
  print('Connected to ${socket.remoteAddress.address}:${socket.remotePort}');

  Timer? timer;

  void sendTemperature(){
    final temperature = 20 + Random().nextDouble() * 15;
    final String message = "Temperatura atual: ${temperature}°C";

    socket.write(message);
    socket.flush();

    print("Client: $message");
  };

  sendTemperature();

  final int duration = 3;
  final int totalTime = 15;
  timer = Timer.periodic(Duration(seconds: duration),
    (Timer t) {
      sendTemperature();
    }
  );

  socket.listen(
    (List<int> data) async{
      final serverResponse = utf8.decode(data).trim();
      print("$serverResponse");

    },
    onError: (error) {
      print("Client: $error");
    },
    onDone: () {
      print("Client: Conexão encerrada, Duração: $totalTime");
      socket.destroy();
    }
  );

  await Future.delayed(Duration(seconds: totalTime));
  timer.cancel();
  socket.destroy();
}
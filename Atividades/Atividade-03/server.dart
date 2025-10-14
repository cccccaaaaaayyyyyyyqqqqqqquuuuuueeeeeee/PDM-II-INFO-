import 'dart:io';

Future<void> main() async{
  final ip = InternetAddress.anyIPv4;
  final int port = 8080;
  final server = await ServerSocket.bind(ip.address, port); // atribui um ip e porta ao server.

  print("O server está rodando no endereço de ip: ${ip.address}:${port}");

  server.listen((Socket client) {
    handleConnection(client); //Serve para informar o server que tá vindo uma conexão. O socket que vai para essa função tá dizendo como se comunicar com esse client específico
  }); // server vai esperar por conexões, quando uma acontecer, ele vai executar esse código.
}

void handleConnection(Socket client){
  print("Server: Conexão do ${client.remoteAddress.address}:${client.remotePort}");
}
import 'dart:io';
import 'dart:convert';

Future<void> main() async{
  final ip = InternetAddress.anyIPv4; //loopbackIpv4 ->Aparentemente pega o ip do localhost, entretanto não permite contato externo na rede. AnyIPv4 -> Permite contato externo na rede??
  final int port = 8080;
  final server = await ServerSocket.bind(ip.address, port); // atribui um ip e porta ao server.

  print("O server está rodando no endereço de ip: ${ip.address}:${port}");

  server.listen((Socket client) {
    handleConnection(client); //Serve para informar o server que tá vindo uma conexão. O socket que vai para essa função tá dizendo como se comunicar com esse client específico

    
  }); // server vai esperar por conexões, quando uma acontecer, ele vai executar esse código.
}


void handleConnection(Socket client){
  print("Server: Conexão do ${client.remoteAddress.address}:${client.remotePort}");

  client.listen(
    (List<int> data) async {
  
      final message = utf8.decode(data).trim();
      print("Server: Temperatura recebida do client: $message");

      client.write("Server: Temperatura chegou com sucesso."); //manda pro listener do client.
    },
    onDone: () {
      print("Server: Client Desconectado");
    }
  );
}
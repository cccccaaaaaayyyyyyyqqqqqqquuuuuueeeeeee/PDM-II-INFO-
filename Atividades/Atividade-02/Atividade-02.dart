// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() => {
    'nome': _nome,
  };
}
//Membros: Os elementos que compõem as classes, atributos e métodos.
//É aquilo que define o comportamento de uma classe
class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() => {
    'nome': _nome,
    'dependentes': _dependentes,
  };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() => {
    'nome do projeto': _nomeProjeto,
    'funcionarios': _funcionarios, 
  };

}

void main() {
  Dependente dependente01 = new Dependente("Cayque");
  Dependente dependente02 = new Dependente("Gustavo");
  Dependente dependente03 = new Dependente("Pedro");
  Dependente dependente04 = new Dependente("Luis");
  Dependente dependente05 = new Dependente("Andre");

  List<Dependente> listaDeDependentes01 = [dependente05, dependente04, dependente03];
  List<Dependente> listaDeDependentes02 = [dependente03, dependente02, dependente01];

  Funcionario funcionario01 = new Funcionario("Pedrovski", listaDeDependentes01);
  Funcionario funcionario02 = new Funcionario("Chadrovski", listaDeDependentes02);
  
  List<Funcionario> listaDeFuncionarios = [funcionario01, funcionario02];

  EquipeProjeto equipeDoProjeto = new EquipeProjeto("Roblox 2", listaDeFuncionarios);

  print(jsonEncode(equipeDoProjeto));
  // 1. Criar varios objetos Dependentes
  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos
  //    funcionarios
  // 4. Criar uma lista de Funcionarios
  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  // 6. Printar no formato JSON o objeto Equipe Projeto.
}

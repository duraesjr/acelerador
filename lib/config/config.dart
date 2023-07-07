import 'dart:convert';

class Config {
  static String urlLogin = "";

  static String? emailUsuarioLogado;

  static carregaDados(String value) {
    dynamic json = jsonDecode(value);
    urlLogin = json['urlLogin'];
  }

  static setEmailUsuarioLogado(String? email) {
    emailUsuarioLogado = email;
  }
}
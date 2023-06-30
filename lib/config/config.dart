import 'dart:convert';

class Config {
  static String urlLogin = "https://portal.meusdividendos.com/";

  static carregaDados(String value) {
    dynamic json = jsonDecode(value);
    urlLogin = json['urlLogin'];
  }
}
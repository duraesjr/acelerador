import 'dart:convert';

class Config {
  static String urlLogin = "";

  static String? emailUsuarioLogado = "";

  static List<dynamic> listaEmailsLinks = List.empty(growable: true);

  static carregarDados(String value) {
    dynamic json = jsonDecode(value);
    urlLogin = json['urlLogin'];
  }

  static setEmailUsuarioLogado(String? email) {
    emailUsuarioLogado = email;
  }

  static String? getEmailUsuarioLogado() {
    return emailUsuarioLogado;
  }

  static void setListaEmails(List<dynamic> lista) {
    listaEmailsLinks.addAll(lista);
    //print(listaEmailsLinks);
  }

  static List<dynamic> getListaEmails(){
    return listaEmailsLinks;
  }

  static bool emailEstaNaLista(String? email) {
    bool achou = false;
    if(listaEmailsLinks.isEmpty) {
      return false;
    } else {
      Iterator<dynamic> it = listaEmailsLinks.iterator;
      while(it.moveNext()) {
        String proximo = it.current['email'];
        if(proximo.trim() == email!.trim()) {
          achou = true;
          break;
        }
      }
    }

    return achou;
  }

  static String getUrlDoUsuario() {
    Iterator<dynamic> it = listaEmailsLinks.iterator;
    String retorno = "https://feldman.studio/en/404/";
    while(it.moveNext()) {
      String proximo = it.current['email'];
      if(proximo.trim() == emailUsuarioLogado?.trim()) {
        retorno = it.current['link'];
        break;
      }
    }
    return retorno;
  }
}
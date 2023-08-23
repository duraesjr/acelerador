# duraes

Webview para visualização de site de um PowerBI.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Como compilar?

- Importante salientar que o projeto pode gerar compilação para IOS, ANDROID e WEB.
- Para gerar compilação para IOS e ANDROID é IMPERATIVO que a branch escolhida seja a versao_apk,
- porque existe uma biblioteca para versão WEB da webview que impede acompilação do app para celular.
- Portanto para gerar uma versão para celular usa-se a branch versao_apk e para gerar versão para web,
- usa-se a branch versao_web.

## Como compilar para Android?

- 1) Acessar a branch versao_apk. ``git checkout versao_apk``
- 2) Limpar o projeto com o comando ``flutter clean``.
- 3) Baixar as dependências com o comando ``flutter pub get``.
- 4) Compilar usando flutter build apk para gerar um arquivo apk em ``build\app\outputs\flutter-apk\app-release.apk.``
- No entanto, as Loja do Google não aceita mais apps no formato apk. Para gerar versão para a loja
- a compilação deve usar o comando ``flutter build appbundle --release`` que gerará o arquivo
- ``build\app\outputs\bundle\release\app-release.aab``.

## Como compilar para Web?

- 1) Acessar a branch versao_web. ``git checkout versao_web``
- 2) Limpar o projeto com o comando ``flutter clean``.
- 3) Baixar as dependências com o comando ``flutter pub get``.
- 4) Compilar usando o comando ``flutter build web``. A compilação é gerada  no diretório build/web
- 5) Opcionalmente é possivel enviar a versão web para o Firebase Hosting através do comando ``firebase deploy``

## Certificado google play

- [Impressão digital certificada MD5] 90:AB:D2:67:7F:C5:A2:19:AB:8E:A2:90:1C:48:7D:5F
- [Impressão digital para certificação SHA-1] C9:7B:90:A7:C9:82:D0:26:10:C5:4A:BC:2B:4A:50:90:51:A8:E9:E2
- [Impressão digital para certificação SHA-256] C1:EB:E6:06:02:8F:07:74:D5:ED:A9:47:FE:A4:F3:50:07:DD:FD:42:03:92:BA:CD:CF:C6:F6:EE:32:4C:9C:BC


## Como adicionar uma "Launcher Icon" da aplicação tanto para Android como para iphone.

- A biblioteca flutter responsável por esta tarefa é a flutter_launcher_icons. Para instalá-la deve-se 
- executar o comando flutter pub add flutter_launcher_icons, que acrescentará no arquivo pubspec.yaml
- o trecho de código abaixo:
``dependencies:
  flutter_launcher_icons: ^0.13.1``

- Para configurar a localização das imagens deve-se adicionar o trecho de código ao arquivo
- pubspec.yaml como demonstrado abaixo:
``flutter_launcher_icons:
  image_path_android: "assets/images/LOGO-ECOMSMART-SEMFUNDO-PRETA.png"
  image_path_ios: "assets/images/image_launcher.png"
  android: true
  ios: true
  remove_alpha_ios: true
  min_sdk_android: 21 # android min sdk min:16, default 21``

- Para mais informações favor consultar ``https://pub.dev/packages/flutter_launcher_icons`` 
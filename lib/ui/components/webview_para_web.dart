// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/config.dart';

class WebViewWeb extends StatefulWidget {
  const WebViewWeb({Key? key}) : super(key: key);

  @override
  WebViewWebState createState() => WebViewWebState();
}

class WebViewWebState extends State<WebViewWeb> {
  String _urlLogin = Config.urlLogin;

  // #docregion platform_features
  late final PlatformWebViewControllerCreationParams _params;

  @override
  void initState() {
    super.initState();

    _params = const PlatformWebViewControllerCreationParams();

    //Emails vindos do firebase
    if (Config.emailEstaNaLista(Config.emailUsuarioLogado) == false) {
      Fluttertoast.showToast(
          msg:
          "Email do usuário não cadastrado no sistema. Favor procurar administrador",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 30,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    _urlLogin = Config.getUrlDoUsuario();
  }

  final PlatformWebViewController _controller = PlatformWebViewController(
    const PlatformWebViewControllerCreationParams(),
  )..loadRequest(
    LoadRequestParams(
      uri: Uri.parse('https://flutter.dev'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    _controller.loadRequest(LoadRequestParams(
      uri: Uri.parse(_urlLogin),
    ),);
    return Scaffold(
      /* Webview sem barra AppBar
      appBar: AppBar(
        title: const Text(''),
        actions: <Widget>[
          _SampleMenu(_controller),
        ],
      ),
      */
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _controller),
      ).build(context),
    );
  }
}

enum _MenuOptions {
  doPostRequest,
}

class _SampleMenu extends StatelessWidget {
  const _SampleMenu(this.controller);

  final PlatformWebViewController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (_MenuOptions value) {
        switch (value) {
          case _MenuOptions.doPostRequest:
            _onDoPostRequest(controller);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<_MenuOptions>>[
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.doPostRequest,
          child: Text('Post Request'),
        ),
      ],
    );
  }

  Future<void> _onDoPostRequest(PlatformWebViewController controller) async {
    final LoadRequestParams params = LoadRequestParams(
      uri: Uri.parse('https://httpbin.org/post'),
      method: LoadRequestMethod.post,
      headers: const <String, String>{
        'foo': 'bar',
        'Content-Type': 'text/plain'
      },
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
    await controller.loadRequest(params);
  }
}
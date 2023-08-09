import 'package:duraes/ui/screens/tela_login.dart';
import 'package:duraes/ui/screens/tela_principal.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:duraes/config/config.dart';

import 'firebase_options.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

final actionCodeSettings = ActionCodeSettings(
  url: 'https://duraes.page.link/muUh',
  handleCodeInApp: true,
  androidInstallApp: false,
  //dynamicLinkDomain: "https://duraes.page.link/muUh",
  androidMinimumVersion: '1',
  androidPackageName: 'br.com.aceleradordeecommerce.duraes',
  iOSBundleId: 'br.com.aceleradordeecommerce.duraes',
);
final emailLinkProviderConfig = EmailLinkAuthProvider(
  actionCodeSettings: actionCodeSettings,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String resultado = await rootBundle.loadString("assets/properties.json");
  Config.carregarDados(resultado);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    //emailLinkProviderConfig,
    //PhoneAuthProvider(),
    //GoogleProvider(clientId: GOOGLE_CLIENT_ID),
    //AppleProvider(),
    //FacebookProvider(clientId: FACEBOOK_CLIENT_ID),
    /*
    TwitterProvider(
      apiKey: TWITTER_API_KEY,
      apiSecretKey: TWITTER_API_SECRET_KEY,
      redirectUri: TWITTER_REDIRECT_URI,
    ),
     */
  ]);

  runApp(const FirebaseAuthUIExample());

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acelerador de Ecommerce',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TelaPrincipal(title: 'Acelerador de Ecommerce'),
    );
  }
}
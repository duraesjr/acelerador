import 'dart:convert';

import 'package:duraes/config/config.dart';
import 'package:duraes/config/rotulos.dart';
import 'package:duraes/main.dart';
import 'package:duraes/ui/components/decorations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

class FirebaseAuthUIExample extends StatelessWidget {
  const FirebaseAuthUIExample({super.key});

  String get initialRoute {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return '/';
    }

    if (!auth.currentUser!.emailVerified && auth.currentUser!.email != null) {
      return '/verify-email';
    }

    //return '/profile';
    return '/powerbi';
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    final mfaAction = AuthStateChangeAction<MFARequired>(
          (context, state) async {
        final nav = Navigator.of(context);

        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );

        nav.pushReplacementNamed('/profile');
      },
    );

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction((context, email) {
                Navigator.pushNamed(
                  context,
                  '/forgot-password',
                  arguments: {'email': email},
                );
              }),
              VerifyPhoneAction((context, _) {
                Navigator.pushNamed(context, '/phone');
              }),
              AuthStateChangeAction<SignedIn>((context, state) {
                if (!state.user!.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!state.credential.user!.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              AuthStateChangeAction<CredentialLinked>((context, state) {
                if (!state.user.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              mfaAction,
              EmailLinkSignInAction((context) {
                Navigator.pushReplacementNamed(context, '/email-link-sign-in');
              }),
            ],
            styles: const {
              EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
            },
            headerBuilder: headerImage('assets/images/image_launcher.png'),
            sideBuilder: sideImage('assets/images/image_launcher.png'),
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Bem vindo ao Acelerador de Ecommerce!'
                      : 'Bem vindo ao Acelerador de Ecommerce! Por favor, crie um conta para continuar.',
                ),
              );
            },
            footerBuilder: (context, action) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    action == AuthAction.signIn
                        ? ''
                        : '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
        '/verify-email': (context) {
          return EmailVerificationScreen(
            headerBuilder: headerIcon(Icons.verified),
            sideBuilder: sideIcon(Icons.verified),
            actionCodeSettings: actionCodeSettings,
            actions: [
              EmailVerifiedAction(() {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
              AuthCancelledAction((context) {
                FirebaseUIAuth.signOut(context: context);
                Navigator.pushReplacementNamed(context, '/');
              }),
            ],
          );
        },
        '/phone': (context) {
          return PhoneInputScreen(
            actions: [
              SMSCodeRequestedAction((context, action, flowKey, phone) {
                Navigator.of(context).pushReplacementNamed(
                  '/sms',
                  arguments: {
                    'action': action,
                    'flowKey': flowKey,
                    'phone': phone,
                  },
                );
              }),
            ],
            headerBuilder: headerIcon(Icons.phone),
            sideBuilder: sideIcon(Icons.phone),
          );
        },
        '/sms': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;

          return SMSCodeInputScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.of(context).pushReplacementNamed('/profile');
              })
            ],
            flowKey: arguments?['flowKey'],
            action: arguments?['action'],
            headerBuilder: headerIcon(Icons.sms_outlined),
            sideBuilder: sideIcon(Icons.sms_outlined),
          );
        },
        '/forgot-password': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'],
            headerMaxExtent: 200,
            headerBuilder: headerIcon(Icons.lock),
            sideBuilder: sideIcon(Icons.lock),
          );
        },
        '/email-link-sign-in': (context) {
          return EmailLinkSignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/');
              }),
            ],
            provider: emailLinkProviderConfig,
            headerMaxExtent: 200,
            headerBuilder: headerIcon(Icons.link),
            sideBuilder: sideIcon(Icons.link),
          );
        },
        '/profile': (context) {
          final platform = Theme.of(context).platform;

          return ProfileScreen(
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/');
              }),
              mfaAction,
            ],
            actionCodeSettings: actionCodeSettings,
            showMFATile: kIsWeb ||
                platform == TargetPlatform.iOS ||
                platform == TargetPlatform.android,
          );
        },
        '/powerbi': (context) {
          FirebaseAuth.instance.authStateChanges().listen((User? user) async {
            if (user == null) {
              debugPrint('Usuário não está logado');
            } else {
              Config.setEmailUsuarioLogado(user.email);
              debugPrint('Usuário está logado');

              //pegando os dados do banco Firebase Realtime.
              final database = FirebaseDatabase.instance;

              DatabaseReference usuariosDb = database.ref();

              final snaphot = await usuariosDb.get();
              Map<dynamic, dynamic> valores =
              snaphot.value as Map<dynamic, dynamic>;

              List<dynamic> lista = tratandoDados(valores);

              Config.setListaEmails(lista);

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const MyApp()));
              //runApp(const MyApp());
            }
          });


          final platform = Theme.of(context).platform;

          return SignInScreen(
            actions: [
              ForgotPasswordAction((context, email) {
                Navigator.pushNamed(
                  context,
                  '/forgot-password',
                  arguments: {'email': email},
                );
              }),
              VerifyPhoneAction((context, _) {
                Navigator.pushNamed(context, '/phone');
              }),
              AuthStateChangeAction<SignedIn>((context, state) {
                if (!state.user!.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/powerbi');
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!state.credential.user!.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              AuthStateChangeAction<CredentialLinked>((context, state) {
                if (!state.user.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              mfaAction,
              EmailLinkSignInAction((context) {
                Navigator.pushReplacementNamed(context, '/email-link-sign-in');
              }),
            ],
            styles: const {
              EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
            },
            headerBuilder: headerImage('assets/images/image_launcher.png'),
            sideBuilder: sideImage('assets/images/image_launcher.png'),
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Bem vindo ao Acelerador de Ecommerce!'
                      : 'Bem vindo ao Acelerador de Ecommerce! Por favor, crie um conta para continuar.',
                ),
              );
            },
            footerBuilder: (context, action) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'By signing in, you agree to our terms and conditions.'
                        : 'By registering, you agree to our terms and conditions.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      },
      title: 'Login',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        FirebaseUILocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('pt'),
      ],
    );
  }

  List<dynamic> tratandoDados(Map<dynamic, dynamic> valores) {
    String usuario = "";

    List<dynamic> lista = List.empty(growable: true);

    valores.forEach((key, value) {
      usuario = value.toString();

      usuario = usuario.replaceAll("link: ", "\"link\": \"");

      usuario = usuario.replaceAll(", email: ", "\",\"email\": \"");

      usuario = usuario.replaceFirst("}", "\"}", usuario.length-5);

      lista.add(json.decode(usuario));
    });
    return lista;
  }
}
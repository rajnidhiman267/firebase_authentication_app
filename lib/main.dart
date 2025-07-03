import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_authentication_app/core/service/firebase/notification_service.dart';
import 'package:firebase_authentication_app/core/view/screens/home_screen.dart';
import 'package:firebase_authentication_app/core/view/screens/login_screen.dart';
import 'package:firebase_authentication_app/core/viewmodel/auth_viewmodel.dart';
import 'package:firebase_authentication_app/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInit();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Authprovider(),
          child: Column(children: [LoginScreen()]),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const WrapperClass());
  }
}

class WrapperClass extends StatelessWidget {
  const WrapperClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(email: snapshot.data?.email ?? '');
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.getDeviceToken();
}

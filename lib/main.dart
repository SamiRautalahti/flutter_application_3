import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/todo_list_manager.dart';
import 'package:flutter_application_3/views/main_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'firebase_options.dart';

//testirivi committia varten

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await dbHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) {
        var model = TodoListManager();
        model.init();
        return model;
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    const String appTitle = 'Flutter layout demo';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 164, 148, 148)),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/main-view',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/main-view');
              }),
            ],
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            providers: providers,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
        '/main-view': (context) {
          return const MainView();
        }
      },
    );
  }
}

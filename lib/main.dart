import 'package:booking/admin/make_plans.dart';
import 'package:booking/admin/models/makeplan_model.dart';
import 'package:booking/auth/login_page.dart';
import 'package:booking/firebase_options.dart';
import 'package:booking/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'helper/helper_function.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(ContactAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> hiveInitialization() async {
    // final dbDir = await path_provider.getApplicationDocumentsDirectory();

    // // init hive
    // await Hive.initFlutter(dbDir.path);
    // await openYourBox();

    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    //init hive
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(MakePlanModelAdapter());
  }

  bool _isSignedIn = false;

  final bool _isAdminSignedIn = false;
  final bool _isNormalUserSignedIn = true;
  // bool admin = true;
  // bool normalUser = false;
  @override
  void initState() {
    super.initState();
    hiveInitialization();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      // home: _isSignedIn ? const HomePage() : const LoginPage(),
      // home: _isNormalUserSignedIn ? const HomePage() : const LoginPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/adminService': (context) => const OnlineBooking(),
      },
    );
  }
}

class OnlineBooking extends StatefulWidget {
  const OnlineBooking({super.key});

  @override
  State<OnlineBooking> createState() => _OnlineBookingState();
}

class _OnlineBookingState extends State<OnlineBooking> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // debugShowCheckedModeBanner: false,
        // title: 'Online booking',
        body: FutureBuilder(
          future: Hive.openBox(
            'make_plans',
            // compactionStrategy: (int total, int deleted) {
            //   return deleted > 20;
            // },
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const MakePlans();
              }
            }
            // Although opening a Box takes a very short time,
            // we still need to return something before the Future completes.
            else {
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Hive.box('contacts').compact();
    // Hive.box('contacts').close(); // close the current box
    Hive.close(); //closes all of the box
    super.dispose();
  }
}

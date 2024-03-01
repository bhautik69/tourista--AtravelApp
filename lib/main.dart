import 'package:demo/Admin/screen/Admin%20Trip%20Management/tripMainpage.dart';
import 'package:demo/Firebase/firebase_options.dart';

import 'package:demo/Screen/Splash%20Screen/splashscreen.dart';

import 'package:sizer/sizer.dart';

import 'package:demo/consts/theme_data.dart';
import 'package:demo/provider/dark_theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';

import 'Admin/screen/adminside.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("it_IT", null);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  void getCurrentTheme() async {
    darkThemeProvider.setDarkTheme =
        await darkThemeProvider.darkThemePrefs.getDarkTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return darkThemeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, provider, child) {
        return Sizer(
          builder: (context, orientation, deviceType) => MaterialApp(
            title: 'Tourista App',
            debugShowCheckedModeBanner: false,
            theme: ThemeStyle.themeDate(provider.getDarkTheme, context),
            home: const Splashscreen(),
          ),
        );
      }),
    );
  }
}

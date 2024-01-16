import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/Network/dio_helper.dart';
import 'Layout/NewsAppLayout.dart';
import 'package:bloc/bloc.dart';
import 'Cubit/blocObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.dio;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Color.fromRGBO(137, 36, 3, 100),
          ),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark),
          color: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Color.fromRGBO(137, 36, 3, 100),
            type: BottomNavigationBarType.fixed,
            elevation: 100),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(100, 137, 36, 31)),
        useMaterial3: true,
      ),
      home: NewsHomeLayout(),
    );
  }
}

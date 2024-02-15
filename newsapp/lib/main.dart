import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/Cubit/blocObserver.dart';
import 'package:newsapp/Cubit/cubit.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Network/cache_helper.dart';
import 'package:newsapp/Network/dio_helper.dart';
import 'Layout/NewsAppLayout.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.dio;
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  runApp(
    BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: MyApp((isDark)),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp(this.isDark);
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSport()
              ..getscience()),
        BlocProvider(
          create: (context) => NewsCubit()..changeAppMode(fromShared: isDark),
        )
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          print('changes ${NewsCubit.get(context).isDark}');

          return MaterialApp(
            title: 'News App',
            theme: ThemeData(
              primarySwatch: Colors.brown,
              textTheme: TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 83, 48, 35),
                ),
                titleMedium: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Color.fromRGBO(137, 36, 3, 100),
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Color.fromRGBO(137, 36, 3, 100),
                type: BottomNavigationBarType.fixed,
                elevation: 100,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(100, 137, 36, 31),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.brown,
              scaffoldBackgroundColor: HexColor('614435'),
              textTheme: TextTheme(
                titleMedium: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('50301F'),
                iconTheme: IconThemeData(
                  color: const Color.fromARGB(255, 211, 166, 150),
                ),
                titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 234, 231, 231),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('50301F'),
                  statusBarBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('705649'),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                elevation: 100,
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: NewsHomeLayout(),
          );
        },
      ),
    );
  }
}

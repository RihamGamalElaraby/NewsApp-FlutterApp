import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/cubit.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Network/dio_helper.dart';
import 'package:newsapp/Screens/SearchScreen.dart';
import 'package:newsapp/Shared/ResusableComponent.dart';

class NewsHomeLayout extends StatelessWidget {
  const NewsHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  NewsCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_2_rounded),
                color:
                    NewsCubit.get(context).isDark ? Colors.white : Colors.brown,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
              onTap: (value) {
                cubit.changeBottomNavBar(value);
              },
              items: cubit.bottomItems),
        );
      },
    );
  }
}

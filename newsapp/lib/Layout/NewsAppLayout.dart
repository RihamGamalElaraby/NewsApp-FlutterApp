import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/cubit.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Network/dio_helper.dart';

class NewsHomeLayout extends StatelessWidget {
  const NewsHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('News App')),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
            ),
            // floatingActionButton: FloatingActionButton(
            //     child: Icon(Icons.add),
            //     onPressed: () {
            //       // DioHelper.getData(path: 'v2/top-headlines', query: {
            //       //   'country': 'eg',
            //       //   'apiKey': 'dfdf1670386e4ae18358d74b803338f8',
            //       // }).then((value) {
            //       //   print(value.data['totalResults']);
            //       // }).catchError((error) {
            //       //   print(error.toString());
            //       // });
            //     }),
            body: cubit.screens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentindex,
                onTap: (value) {
                  cubit.changeBottomNavBar(value);
                },
                items: cubit.bottomItems),
          );
        },
      ),
    );
  }
}

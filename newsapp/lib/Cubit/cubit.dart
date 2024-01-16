import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Screens/BusinessScreen.dart';
import 'package:newsapp/Screens/ScientifScreen.dart';
import 'package:newsapp/Screens/SettingsScreen.dart';
import 'package:newsapp/Screens/SportsScreen.dart';
import 'package:newsapp/Network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        label: 'Business',
        icon: Icon(
          Icons.business_center_outlined,
        )),
    BottomNavigationBarItem(
        label: 'Scientific ',
        icon: Icon(
          Icons.science_rounded,
        )),
    BottomNavigationBarItem(
        label: 'Sports',
        icon: Icon(
          Icons.sports,
        )),
    BottomNavigationBarItem(
        label: 'Settings',
        icon: Icon(
          Icons.settings,
        ))
  ];

  void changeBottomNavBar(int index) {
    currentindex = index;
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    ScienticScreen(),
    SportsScreen(),
    SettingsScreen()
  ];

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'dfdf1670386e4ae18358d74b803338f8',
    }).then((value) {
      if (value.data['articles'] != null) {
        business = List<Map<String, dynamic>>.from(value.data['articles']);
        print(business[0]['title']);
        emit(NewsGetBusinessSucssesState());
      } else {
        // Handle the case where 'articles' key is not present or is null
        emit(NewsGetBusinessErrorState('Invalid response data'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
}

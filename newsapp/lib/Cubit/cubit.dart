import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/states.dart';
import 'package:newsapp/Network/cache_helper.dart';
import 'package:newsapp/Screens/BusinessScreen.dart';
import 'package:newsapp/Screens/ScientifScreen.dart';
// import 'package:newsapp/Screens/SettingsScreen.dart';
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
  ];

  void changeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1) getscience();
    if (index == 2) getSport();
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    ScienticScreen(),
    SportsScreen(),
    // SettingsScreen()
  ];

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'us',
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

  List<dynamic> science = [];

  void getscience() {
    emit(NewsGetScientificLoadingState());
    DioHelper.getData(path: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'science',
      'apiKey': 'dfdf1670386e4ae18358d74b803338f8',
    }).then((value) {
      if (value.data['articles'] != null) {
        science = List<Map<String, dynamic>>.from(value.data['articles']);
        emit(NewsGetScientificSucssesState());
      } else {
        emit(NewsGetScientificErrorState('Invalid response data'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScientificErrorState(error.toString()));
    });
  }

  List<dynamic> Sport = [];

  void getSport() {
    emit(NewsGetSportsLoadingState());

    if (Sport.length == 0) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'dfdf1670386e4ae18358d74b803338f8',
      }).then((value) {
        if (value.data['articles'] != null) {
          Sport = List<Map<String, dynamic>>.from(value.data['articles']);
          emit(NewsGetSportsSucssesState());
        } else {
          // Handle the case where 'articles' key is not present or is null
          emit(NewsGetSportsErrorState('Invalid response data'));
        }
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucssesState());
    }
  }

  List<dynamic> search = [];

  void getssearch(String value) {
    emit(NewsGetsearchLoadingState());

    DioHelper.getData(path: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'dfdf1670386e4ae18358d74b803338f8',
    }).then((value) {
      if (value.data['articles'] != null) {
        search = List<Map<String, dynamic>>.from(value.data['articles']);
        emit(NewsGetsearchSucssesState());
      } else {
        emit(NewsGetsearchErrorState('Invalid response data'));
      }
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetsearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        print('app mode changed to $isDark');
        emit(AppChangeModeStates());
      });
    }
  }
}

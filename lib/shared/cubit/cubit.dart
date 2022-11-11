import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/cubit/stats.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remot/dio_helper.dart';
import 'package:untitled/shared/cubit/stats.dart';

import '../../modules/news_app/business/business_screen.dart';
import '../../modules/news_app/science/science.dart';
import '../../modules/news_app/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_basketball,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.settings,
    //   ),
    //   label: 'settings',
    //
    // ),
  ];
  List<Widget?> Screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> businessNews = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    //="https://drive.google.com/uc?export=download&id=1Xwy4OzKp6IGj27u-y0EZ3LSd-qNR5cTb";
    //https://drive.google.com/file/d/1Xwy4OzKp6IGj27u-y0EZ3LSd-qNR5cTb/view?usp=sharing
    //https://drive.google.com/file/d/1IT47gxE6dURlSeUp34T43e-rOFxmwe0a/view?usp=sharing
    if (businessNews.length == 0) {
      DioHelper.getData(
        url: 'uc',
        query: {
          'export': 'download',
          'id': '1IT47gxE6dURlSeUp34T43e-rOFxmwe0a',
        },
      )?.then((value) {
        //print(value?.data[0]);
        businessNews = value?.data;
        print(businessNews[0]);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sportsNews = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    //="https://drive.google.com/uc?export=download&id=1Xwy4OzKp6IGj27u-y0EZ3LSd-qNR5cTb";
    // https://drive.google.com/file/d/1IT47gxE6dURlSeUp34T43e-rOFxmwe0a/view
    // https://drive.google.com/file/d/1GVWkX47K1hjWan_xw4xRbD-zWl0zr2oE/view
    if (sportsNews.length == 0) {
      DioHelper.getData(
        url: 'uc',
        query: {
          'export': 'download',
          'id': '1GVWkX47K1hjWan_xw4xRbD-zWl0zr2oE',
        },
      )?.then((value) {
        //print(value?.data[0]);
        sportsNews = value?.data;
        print(sportsNews[0]);

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> scienceNews = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    //="https://drive.google.com/uc?export=download&id=1IT47gxE6dURlSeUp34T43e-rOFxmwe0a";

    //https://drive.google.com/file/d/1IT47gxE6dURlSeUp34T43e-rOFxmwe0a/view?usp=sharing
    if (scienceNews.length == 0) {
      DioHelper.getData(
        url: 'uc',
        query: {
          'export': 'download',
          'id': '1IT47gxE6dURlSeUp34T43e-rOFxmwe0a',
        },
      )?.then((value) {
        //print(value?.data[0]);
        scienceNews = value?.data;
        print(scienceNews[0]);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  var searchController = TextEditingController();
  List<dynamic> searchNews = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    print(value);

    DioHelper.getDatah(
      url: 'v2/everything',
      query: {
        'q': '${value}',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    )?.then((value) {
      //print(value?.data[0]);
      searchNews = value?.data['articles'];
      print(searchNews[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool isDark = false;
  void changeAppMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsGChangeModeState());
      });
    }
  }
}

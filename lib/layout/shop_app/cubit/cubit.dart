import 'dart:math';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/change_favorites_model.dart';
import '../../../shared/componants/componant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/Categories_modele.dart';
import 'package:untitled/modules/shop_app/Settings/settings_screen.dart';
import 'package:untitled/modules/shop_app/categories/categories_screen.dart';
import 'package:untitled/modules/shop_app/favorits/favorits_screen.dart';
import 'package:untitled/modules/shop_app/products/products_screen.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remot/dio_helper.dart';

import '../../../models/home_moodel.dart';
import '../../../shared/componants/componant.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritsScreen(),
    SettingsScreen(),
  ];

  void changCurrentIndexe(int index) {
    currentIndex = index;
    emit(ShopChangBottomNavState());
  }

  HomeModel? homeModel;
  bool? test;
  Map<int?, bool?>? favorites = {};
  List<Products>? favoritesProduct = [];
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      lan: 'en',
      token: token,
    )?.then((value) {
      homeModel = HomeModel.fromjson(value?.data);
      print(homeModel?.data?.banners![0].image);

      homeModel!.data!.products!.forEach(
        (element) {
          if (element.inFavorites == true) {
            favoritesProduct?.add(element);
          }
          favoritesProduct = [];
          favorites!.addAll({element.id: element.inFavorites});
          //print('elment ${element.id} ...${element.inFavorites}');
        },
      );
      print(favorites.toString());
      emit(ShopSeccesHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrHomeDataState(error.toString()));
    });
  }

  void emitState1() {
    name = CacheHelper.getData1(key: 'name');
    emit(ShopChangFavoritesState());
  }

  IconData suffix = Icons.visibility_outlined;
  bool ispass = true;
  void changePasssVisibility() {
    ispass = !ispass;
    if (ispass) {
      suffix = Icons.visibility_off_outlined;
    } else {
      suffix = Icons.visibility_outlined;
    }
    emit(ShopLoginChangePasssVisibilityState());
  }

  String? name = CacheHelper.getData1(key: 'name');
  void getHomeData2() async {
    emit(ShopLoadingHomeDataState());
    //String url = "https://student.valuxapps.com/api/home?lang=en&Content-Type=application/json&Authorizatio=${token}";
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GET_CATEGORES,
      lan: 'en',
    )?.then((value) {
      categoriesModel = CategoriesModel.fromjson(value?.data);
      print(categoriesModel?.data?.data![0].name);
      print(categoriesModel?.status);
      emit(ShopSeccesCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErorrCategoriesState(error.toString()));
    });
  }

  ChangFavoritesModele? changFavoritesModele;

  void ChangeFavorites(int? id) {
    if (favorites![id] == true) {
      favorites![id] = false;
      emit(ShopChangFavoritesState());
      favoritesProduct!.forEach(
        (element) {
          if (element.id == id) {
            favoritesProduct?.remove(element);
          }
        },
      );
    } else {
      favorites![id] = true;
      homeModel!.data!.products!.forEach(
        (element) {
          if (element.id == id) {
            favoritesProduct?.add(element);
          }
        },
      );
    }
    emit(ShopChangFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': id},
      token: token,
      lan: 'en',
    )?.then((value) {
      changFavoritesModele = ChangFavoritesModele.fromjson(value?.data);
      if (changFavoritesModele?.status == true) //must be false
      {
        if (favorites![id] == true)
          favorites![id] = false;
        else
          favorites![id] = true;
      }

      emit(ShopSeccesChangFavoritesState(changFavoritesModele!));
    }).catchError((erorr) {
      if (favorites![id] == true)
        favorites![id] = false;
      else
        favorites![id] = true;
      emit(ShoperrorChangFavoritesState(erorr.toString()));
    });
  }
}

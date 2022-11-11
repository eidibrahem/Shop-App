import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/shared/network/remot/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());
  static ShopLoginCubit git(context) => BlocProvider.of(context);

  ShopLoginMoDel? loginMoDel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLogLodingState());
    DioHelper.postData(
            url: LOGIN, data: {"email": email, "password": password}, lan: 'en')
        ?.then((value) {
      loginMoDel = ShopLoginMoDel.fromjson(value!.data);
      print(value.data['message']);
      print(loginMoDel!.status);

      emit(ShopLoginSucccessState(loginMoDel));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(ShopLoginErorrState(error.toString()));
    });
  }

  void emitState1() {
    emit(ShopLogLodingState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopLogLodingState());
    DioHelper.postData(
            url: REGISTER,
            data: {
              "name": name,
              "email": email,
              "password": password,
              "phone": phone,
            },
            lan: 'en')
        ?.then((value) {
      loginMoDel = ShopLoginMoDel.fromjson(value!.data);
      emit(ShopLoginSucccessState(loginMoDel));
    }).onError((error, stackTrace) {
      print(error.toString());
      emit(ShopLoginErorrState(error.toString()));
    });
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
}

import 'package:untitled/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLogLodingState extends ShopLoginStates {}

class ShopLoginSucccessState extends ShopLoginStates {
  final ShopLoginMoDel? loginMoDel;
  ShopLoginSucccessState(this.loginMoDel);
}

class ShopLoginErorrState extends ShopLoginStates {
  final String error;
  ShopLoginErorrState(this.error);
}

class ShopLoginChangePasssVisibilityState extends ShopLoginStates {}

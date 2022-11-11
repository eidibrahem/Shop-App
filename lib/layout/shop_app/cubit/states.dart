import 'package:untitled/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopIntialState extends ShopStates {}

class ShopChangBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSeccesHomeDataState extends ShopStates {}

class ShopErorrHomeDataState extends ShopStates {
  final String error;
  ShopErorrHomeDataState(this.error);
}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSeccesCategoriesState extends ShopStates {}

class ShopErorrCategoriesState extends ShopStates {
  final String error;
  ShopErorrCategoriesState(this.error);
}

class ShopChangFavoritesState extends ShopStates {}
class ShopLoginChangePasssVisibilityState  extends ShopStates {}
class ShopSeccesChangFavoritesState extends ShopStates {
  final ChangFavoritesModele modele;
  ShopSeccesChangFavoritesState(this.modele);
}

class ShoperrorChangFavoritesState extends ShopStates {
  final String error;
  ShoperrorChangFavoritesState(this.error);
}

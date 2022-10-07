import '../../../models/change favorite/change_favorite.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopHomeLoadingState extends ShopHomeStates {}

class ShopHomeSuccessState extends ShopHomeStates {}

class ShopHomeErrorState extends ShopHomeStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategorySuccessState extends ShopHomeStates {}

class ShopCategoryErrorState extends ShopHomeStates {
  final String error;

  ShopCategoryErrorState(this.error);
}

class ShopChangeFavoriteIconState extends ShopHomeStates {}

class ShopChangeFavoritesSuccessState extends ShopHomeStates {
  final ChangeFavoriteModel changeFavoriteModel;
  ShopChangeFavoritesSuccessState(this.changeFavoriteModel);
}

class ShopChangeFavoritesErrorState extends ShopHomeStates {
  final String error;

  ShopChangeFavoritesErrorState(this.error);
}

class ShopHomeChangeNavBarState extends ShopHomeStates {}

class ShopFavoriteSuccessState extends ShopHomeStates {}

class ShopFavoriteErrorState extends ShopHomeStates {
  final String error;

  ShopFavoriteErrorState(this.error);
}

class ShopGetProfileSuccessState extends ShopHomeStates {}

class ShopGetProfileErrorState extends ShopHomeStates {
  final String error;

  ShopGetProfileErrorState(this.error);
}

class ShopAddToCartState extends ShopHomeStates {}

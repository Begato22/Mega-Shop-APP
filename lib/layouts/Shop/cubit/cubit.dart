// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/change%20favorite/change_favorite.dart';
import 'package:shop_app/modules/carts/carts_screen.dart';

import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import '../../../models/favorite model/favorite_model.dart';
import '../../../models/profile model/profile_model.dart';
import '../../../models/shop categories model/shop_categories_model.dart';
import '../../../models/shop home model/shop_home_model.dart';
import '../../../modules/category/category_screen.dart';
import 'states.dart';

class ShopHomeCubite extends Cubit<ShopHomeStates> {
  ShopHomeCubite() : super(ShopHomeInitialState());

  static ShopHomeCubite get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titleScreen = [
    'Products',
    'Category',
    'Carts',
    'Favorites',
    'Settings',
  ];
  List<Widget> screens = const [
    ProductsScreen(),
    CategoryScreen(),
    CartsScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.grid_4x4),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag),
      label: 'Carts',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  void changeNavBar(int index) {
    currentIndex = index;
    emit(ShopHomeChangeNavBarState());
  }

  Map<int, bool> favorite = {};

  HomeDataModel? dataModel;

  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then(
      (value) {
        dataModel = HomeDataModel.fromJson(value.data);
        for (var item = 0;
            item < dataModel!.homeData!.products.length;
            item++) {
          favorite[dataModel!.homeData!.products[item].id] =
              dataModel!.homeData!.products[item].inFavorites;
        }
        emit(ShopHomeSuccessState());
      },
    ).catchError(
      (err) {
        print(" errrrrrrrrr ${err.toString()}");
        emit(ShopHomeErrorState(err.toString()));
      },
    );
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    DioHelper.getData(url: GET_CATEGORIES).then(
      (value) {
        categoryModel = CategoryModel.fromJson(value.data);
        print(categoryModel.toString());
        emit(ShopCategorySuccessState());
      },
    ).catchError(
      (err) {
        print(" errrrrrrrrr ${err.toString()}");
        emit(ShopCategoryErrorState(err.toString()));
      },
    );
  }

  List<Products> cart = [];
  void addToCart(Products product) {
    if (cart.contains(product)) {
      cart.remove(product);
    } else {
      cart.add(product);
    }
    emit(ShopAddToCartState());
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorait(int productID) {
    print("every thing is done 1");
    favorite[productID] = !favorite[productID]!;
    print("every thing is done 1");
    emit(ShopChangeFavoriteIconState());
    getFavorite();

    // favorite![productID] = !favorite![productID];
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productID},
      token: token,
    ).then(
      (value) {
        changeFavoriteModel = ChangeFavoriteModel.froJson(value.data);
        getFavorite();
        if (!changeFavoriteModel!.status) {
          favorite[productID] = !favorite[productID]!;
          print(changeFavoriteModel!.message);
          emit(ShopChangeFavoriteIconState());
        }
        emit(ShopChangeFavoritesSuccessState(changeFavoriteModel!));
      },
    ).catchError(
      (err) {
        emit(ShopChangeFavoritesErrorState(err.toString()));
      },
    );
  }

  FavoriteModel? favoriteDataModel;
  void getFavorite() {
    DioHelper.getData(url: FAVORITES, token: token).then(
      (value) {
        favoriteDataModel = FavoriteModel.fromJson(value.data);

        print(
            "before goooooooooooooo ${favoriteDataModel!.favoriteDataModel!.data.length}");
        emit(ShopFavoriteSuccessState());
      },
    ).catchError(
      (err) {
        print(err.toString());
        emit(ShopFavoriteErrorState(err.toString()));
      },
    );
  }

  ProfileModel? userModel;
  void getProfile() {
    DioHelper.getData(url: PROFILE, token: token).then(
      (value) {
        print("object 1");
        userModel = ProfileModel.fromJson(value.data);
        print("object 2");
        print(value.data['data']['name']);
        print("before goooooooooooooo ${userModel!.userDate!.name}");
        emit(ShopGetProfileSuccessState());
      },
    ).catchError(
      (err) {
        print(err.toString());
        emit(ShopGetProfileErrorState(err.toString()));
      },
    );
  }
}

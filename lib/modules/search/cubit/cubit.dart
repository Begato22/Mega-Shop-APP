// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import '../../../models/search model/search_model.dart';
import 'states.dart';

class ShopSearchubite extends Cubit<ShopSearchStates> {
  ShopSearchubite() : super(ShopSearchInitialState());

  static ShopSearchubite get(context) => BlocProvider.of(context);

  SearchModel? productSearched;

  void getSearchedProducts(String text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token,
      data: {'text': text},
    ).then(
      (value) {
        print("object 11");
        productSearched = SearchModel.fromJson(value.data);
        print("object 12");
        emit(ShopSearchSuccessState());
      },
    ).catchError(
      (err) {
        print(" errrrrrrrrr ${err.toString()}");
        emit(ShopSearchErrorState(err.toString()));
      },
    );
  }
}

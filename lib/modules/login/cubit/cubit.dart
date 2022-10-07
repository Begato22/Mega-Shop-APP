// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login%20model/login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import 'states.dart';

class ShopLoginCubite extends Cubit<ShopLoginStates> {
  ShopLoginCubite() : super(ShopLoginInitialState());

  static ShopLoginCubite get(context) => BlocProvider.of(context);

  //for change visivility of Password 17 => 28
  bool securePassword = true;
  IconData visibleIcon = Icons.visibility;
  void changeVisability() {
    if (securePassword) {
      visibleIcon = Icons.visibility_off;
      securePassword = !securePassword;
    } else {
      visibleIcon = Icons.visibility;
      securePassword = !securePassword;
    }
    emit(ShopLoginChangeVisabilityState());
  }

  //for User Login Page 31 => 57
  LoginModel? loginModel;
  void login({
    required String email,
    required String password,
  }) {
    print("Dear Shop look here !  $email  and $password from Cubit");
    emit(ShopLoginLodingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        print("Shop ! Hi I call You from Login From Your Cubit.");
        print("From ShopLoginSuccessState $value.data}");
        loginModel = LoginModel.fromJson(value.data);
        print("your token is ${loginModel!.userDate!.token}");
        emit(ShopLoginSuccessState());
      },
    ).catchError(
      (err) {
        print("Shop Error: ${err.toString()}");
        emit(ShopLoginErrorState(err.toString()));
      },
    );
  }
}

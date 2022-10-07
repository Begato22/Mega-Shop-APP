// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register%20model/register_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import 'states.dart';

class ShopRegisterCubite extends Cubit<ShopRegisterStates> {
  ShopRegisterCubite() : super(ShopRegisterInitialState());

  static ShopRegisterCubite get(context) => BlocProvider.of(context);

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
    emit(ShopRegisterChangeVisabilityState());
  }

  //for User Login Page 31 => 57
  RegisterModel? loginModel;
  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLodingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then(
      (value) {
        loginModel = RegisterModel.fromJson(value.data);
        emit(ShopRegisterSuccessState());
      },
    ).catchError(
      (err) {
        print("Shop Error: ${err.toString()}");
        emit(ShopRegisterErrorState(err.toString()));
      },
    );
  }
}

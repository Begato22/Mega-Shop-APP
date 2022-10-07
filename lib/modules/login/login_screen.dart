// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';

import '../../shared/components/component.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cach_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubite(),
      child: BlocConsumer<ShopLoginCubite, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (ShopLoginCubite.get(context).loginModel!.status) {
              CashHelper.setData(
                      key: 'token',
                      value: ShopLoginCubite.get(context)
                          .loginModel!
                          .userDate!
                          .token)
                  .then(
                (value) {
                  print(
                      "This Image Profile URL: ${ShopLoginCubite.get(context).loginModel!.userDate!.image}");
                  if (value) {
                    token = ShopLoginCubite.get(context)
                        .loginModel!
                        .userDate!
                        .token;
                    navigateAndRemoveTo(context, const ShopLayout());
                  }
                  showToast(
                    ShopLoginCubite.get(context).loginModel!.message,
                    ToastState.success,
                  );
                  // emailController.text = passwordController.text = "";
                },
              );
            } else {
              showToast(
                ShopLoginCubite.get(context).loginModel!.message,
                ToastState.error,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubite.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Login now to browse our hot offers.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                        defultTextField(
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          label: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "You should enter valid email address";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        defultTextField(
                          controller: passwordController,
                          prefix: Icons.lock_outline,
                          label: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.securePassword,
                          suffix: cubit.visibleIcon,
                          suffixFunc: () => cubit.changeVisability(),
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "You should enter valid password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        state is! ShopLoginLodingState
                            ? defultButton(
                                onPressed: () {
                                  print("object");
                                  if (formKey.currentState!.validate()) {
                                    print(
                                        "Dear Shop look here !  ${emailController.text}  and ${passwordController.text}");
                                    ShopLoginCubite.get(context).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                lable: "login",
                              )
                            : const Center(
                                child: Text("Wait ..."),
                                // child: CircularProgressIndicator(),
                              ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Dont't have an account? "),
                            const SizedBox(width: 3),
                            defultTextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                lable: "register"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

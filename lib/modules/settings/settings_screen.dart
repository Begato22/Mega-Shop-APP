import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/network/local/cach_helper.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubite, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ShopHomeCubite.get(context).userModel;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: defultColor,
                      child: CircleAvatar(
                        radius: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image(
                            image: NetworkImage(userModel!.userDate!.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          userModel.userDate!.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userModel.userDate!.email,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                buildFeildData('Phone', userModel.userDate!.phone.toString()),
                buildFeildData('Points', userModel.userDate!.points.toString()),
                buildFeildData('Credit', userModel.userDate!.credit.toString()),
                defultButton(
                  onPressed: () {
                    CashHelper.removeData(key: 'token').then(
                      (value) {
                        if (value) {
                          navigateAndRemoveTo(
                            context,
                            const LoginScreen(),
                          );
                        }
                      },
                    );
                  },
                  lable: 'LOGOUT',
                ),
                const Spacer(),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Developed By '),
                        TextSpan(
                          text: 'Eslam Nour Eldeen',
                          style: TextStyle(
                              color: defultColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildFeildData(String feildData, String data) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$feildData: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

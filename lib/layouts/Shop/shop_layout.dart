import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubite, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,
                ),
                const Text('BEGO'),
              ],
            ),
            actions: [
              if (ShopHomeCubite.get(context).currentIndex == 0)
                buildShoppingBag(context),
              if (ShopHomeCubite.get(context).currentIndex !=
                  ShopHomeCubite.get(context).screens.length - 1)
                IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: makeCustomCircleAvatar(iconData: Icons.search),
                ),
            ],
          ),
          body: ShopHomeCubite.get(context)
              .screens[ShopHomeCubite.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 100,
            items: ShopHomeCubite.get(context).navBarItems,
            currentIndex: ShopHomeCubite.get(context).currentIndex,
            selectedItemColor: defultColor,
            unselectedItemColor: Colors.grey[300],
            onTap: (index) {
              ShopHomeCubite.get(context).changeNavBar(index);
            },
          ),
        );
      },
    );
  }
}

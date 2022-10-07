import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/shared/components/component.dart';

import 'package:shop_app/models/favorite%20model/favorite_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubite, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Data> favoriteDataModelList = [];
        favoriteDataModelList = ShopHomeCubite.get(context)
            .favoriteDataModel!
            .favoriteDataModel!
            .data;
        return favoriteDataModelList.isEmpty
            ? Center(child: buildEmptyWidgetitem(Icons.menu, 'Favorite'))
            : Scaffold(
                body: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => buildProductCardItem(
                      favoriteDataModelList, index, context),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: favoriteDataModelList.length,
                ),
              );
      },
    );
  }
}

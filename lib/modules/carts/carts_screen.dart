import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/shared/components/component.dart';

import '../../shared/styles/colors.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubite, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> cartsList = [];
        cartsList = ShopHomeCubite.get(context).cart;
        return cartsList.isEmpty
            ? Center(child: buildEmptyWidgetitem(Icons.shopping_bag, 'Cart'))
            : Scaffold(
                body: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      buildProductItem(cartsList, index, context),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: cartsList.length,
                ),
              );
      },
    );
  }

  Widget buildProductItem(
      List<dynamic> listItem, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 5,
        child: Container(
          height: 120,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage(listItem[index].image),
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 5),
              // Container(height: 90, width: 1, color: defultColor.withOpacity(0.3)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      listItem[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${listItem[index].price.round()} EG",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defultColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => ShopHomeCubite.get(context)
                              .addToCart(listItem[index]),
                          child: CircleAvatar(
                            child:
                                const Icon(Icons.remove, color: Colors.red),
                            backgroundColor: Colors.grey[300],
                            radius: 15,
                          ),
                        ),
                        showFavIcon(listItem[index].id, context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

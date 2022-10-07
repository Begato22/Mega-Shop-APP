import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/shared/components/component.dart';

import '../../shared/styles/colors.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({Key? key, required this.product}) : super(key: key);
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubite, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // bool isButtonDisabled =
        //     ShopHomeCubite.get(context).cart.contains(product);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Back"),
            actions: [
              if (ShopHomeCubite.get(context).cart.contains(product))
                GestureDetector(
                  onTap: () {
                    ShopHomeCubite.get(context).addToCart(product);
                  },
                  child: makeCustomCircleAvatar(
                    iconData: Icons.remove_shopping_cart,
                    color: Colors.red,
                  ),
                ),
              buildShoppingBag(context),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image(
                      image: NetworkImage(product.image),
                      height: 350,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      thickness: 1,
                      endIndent: 0.1,
                      color: defultColor.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            const TextSpan(text: "Price: "),
                            TextSpan(
                              text: product.price.toString(),
                            ),
                            const TextSpan(
                                text: " EG",
                                style: TextStyle(
                                    color: defultColor, fontSize: 16)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      showFavIcon(product.id, context),
                    ],
                  ),
                  const SizedBox(height: 5),
                  if (product.discount != 0)
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              children: [
                                const TextSpan(
                                    text: "Old Price: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: product.oldPrice.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        decoration:
                                            TextDecoration.lineThrough)),
                                const TextSpan(
                                  text: "EG",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 7,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: Colors.green[200],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 1) // changes position of shadow
                                    ),
                              ],
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                                children: [
                                  const TextSpan(
                                      text: "Discount: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "${product.discount}%",
                                    style: const TextStyle(color: defultColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 25),
                  defultButton(
                    isDisabled:
                        ShopHomeCubite.get(context).cart.contains(product)
                            ? true
                            : false,
                    onPressed: () {
                      ShopHomeCubite.get(context).addToCart(product);
                    },
                    lable: 'Add to Cart',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

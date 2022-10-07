import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/models/shop%20home%20model/shop_home_model.dart';
import 'package:shop_app/modules/item%20product/item_product.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/shop categories model/shop_categories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubite, ShopHomeStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessState) {
          if (!state.changeFavoriteModel.status) {
            showToast(state.changeFavoriteModel.message, ToastState.error);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopHomeCubite.get(context);
        return Scaffold(
          body: cubit.dataModel != null && cubit.categoryModel != null
              ? builderProductes(cubit, context)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget builderProductes(ShopHomeCubite cubit, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: cubit.dataModel!.homeData!.banners.map(
                (e) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image(
                        image: NetworkImage(e.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            buildTitle("Category"),
            const SizedBox(height: 20),
            SizedBox(
              height: 100.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoryItem(cubit.categoryModel, index),
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 10.0),
                itemCount: cubit.categoryModel!.categoryDataModel!.data.length,
              ),
            ),
            const SizedBox(height: 30),
            buildTitle("New Products"),
            const SizedBox(height: 20),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1 / 1.9,
                children: cubit.dataModel!.homeData!.products.map(
                  (e) {
                    return buildGridItem(e, context);
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
    );
  }

  Widget buildCategoryItem(CategoryModel? categoryModel, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 105,
              width: 105,
              color: defultColor,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                        categoryModel!.categoryDataModel!.data[index].image),
                    fit: BoxFit.cover,
                    width: 96,
                    height: 96,
                  ),
                  Container(
                    width: 100.0,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      categoryModel.categoryDataModel!.data[index].name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                    color: Colors.black.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridItem(Products product, context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ItemProduct(product: product));
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image(
                        image: NetworkImage(product.image),
                        width: double.infinity,
                        height: 200.0,
                      ),
                    ),
                    if (product.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 2.0),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            Text(
                              "${product.price.round()} EG",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defultColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 5),
                            if (product.discount != 0)
                              Text(
                                "${product.oldPrice}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                      showFavIcon(product.id, context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

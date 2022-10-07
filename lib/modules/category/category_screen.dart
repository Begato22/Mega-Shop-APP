import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/cubit/states.dart';
import 'package:shop_app/models/shop%20categories%20model/shop_categories_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopHomeCubite, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Data> categoryModelList = ShopHomeCubite.get(context)
              .categoryModel!
              .categoryDataModel!
              .data;
          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCategoryItem(categoryModelList[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 12.0,
                child: Divider(height: 1),
              ),
              itemCount: categoryModelList.length,
            ),
          );
        },
      ),
    );
  }

  Widget buildCategoryItem(Data categoryModel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Container(
              color: Colors.white,
              child: Image(
                image: NetworkImage(categoryModel.image),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            categoryModel.name,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

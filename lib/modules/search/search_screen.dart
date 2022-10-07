import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import '../../models/search model/search_model.dart';
import '../../shared/components/component.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey();
    var queryController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopSearchubite(),
      child: BlocConsumer<ShopSearchubite, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: queryController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must insert Query';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Search'),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        ShopSearchubite.get(context).getSearchedProducts(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 30),
                    if (state is ShopSearchInitialState)
                      buildEmptyWidgetitem(Icons.search, 'Search'),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildProductItem(
                            ShopSearchubite.get(context)
                                .productSearched!
                                .searchDataModel!
                                .data,
                            index,
                            context,
                          ),
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: 1),
                          itemCount: ShopSearchubite.get(context)
                              .productSearched!
                              .searchDataModel!
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProductItem(
      List<Product> listItem, int index, BuildContext context) {
    return Card(
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
                      showFavIcon(listItem[index].id, context),
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

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../layouts/Shop/cubit/cubit.dart';
import '../../modules/item product/item_product.dart';

void navigateAndRemoveTo(context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
void navigateTo(context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

Widget defultButton({
  required Function onPressed,
  required String lable,
  bool isDisabled = false,
  Color color = defultColor,
}) =>
    SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () => isDisabled ? null : onPressed(),
        child: Text(
          lable.toUpperCase(),
        ),
        style: ElevatedButton.styleFrom(
          primary: isDisabled ? Colors.grey : defultColor,
        ),
      ),
    );

Widget defultTextButton({
  required Function onPressed,
  required String lable,
}) =>
    TextButton(
      onPressed: () => onPressed(),
      child: Text(
        lable.toUpperCase(),
        style: const TextStyle(
          color: defultColor,
        ),
      ),
    );

Widget defultTextField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required IconData prefix,
  IconData? suffix,
  Function? suffixFunc,
  required Function validator,
  required String label,
  bool obscureText = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: GestureDetector(
          child: Icon(suffix),
          onTap: () => suffixFunc!(),
        ),
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: (val) => validator(val),
    );

enum ToastState { success, error, warning }
Future<bool?> showToast(String message, ToastState state) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: changeColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
Color changeColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget showFavIcon(int id, context) {
  var cubit = ShopHomeCubite.get(context);
  return IconButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      cubit.changeFavorait(id);
    },
    icon: ShopHomeCubite.get(context).favorite[id] == true
        ? const Icon(
            Icons.favorite,
            color: Colors.red,
          )
        : const Icon(
            Icons.favorite_border,
            color: Colors.grey,
          ),
  );
}

Widget makeCustomCircleAvatar(
    {Color color = Colors.black, required IconData iconData}) {
  return CircleAvatar(
    backgroundColor: Colors.grey[300],
    child: Icon(
      iconData,
      color: color,
      size: 20,
    ),
  );
}

Widget buildProductCardItem(
    List<dynamic> listItem, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GestureDetector(
      onTap: () {
        navigateTo(context, ItemProduct(product: listItem[index].product));
      },
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
                      image: NetworkImage(listItem[index].product!.image),
                      width: double.infinity,
                    ),
                    if (listItem[index].product!.discount != 0)
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
                      listItem[index].product!.name,
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
                              "${listItem[index].product!.price.round()} EG",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defultColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 5),
                            if (listItem[index].product!.discount != 0)
                              Text(
                                "${listItem[index].product!.oldPrice.round()}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                        showFavIcon(listItem[index].product!.id, context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildEmptyWidgetitem(IconData iconData, String feildName) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 100,
          color: defultColor.withOpacity(0.3),
        ),
        Text('No Item added to $feildName.')
      ],
    ),
  );
}

Widget buildShoppingBag(context) => Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        alignment: const Alignment(0.5, 0.5),
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_bag,
              size: 30,
            ),
          ),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Text(
              ShopHomeCubite.get(context).cart.length.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

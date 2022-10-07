// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewItem {
  final String umgURL;
  final String title;
  final String body;

  PageViewItem({required this.umgURL, required this.title, required this.body});
}

bool isLast = false;

class OnBorderingScreen extends StatefulWidget {
  const OnBorderingScreen({Key? key}) : super(key: key);

  @override
  State<OnBorderingScreen> createState() => _OnBorderingScreen();
}

class _OnBorderingScreen extends State<OnBorderingScreen> {
  List<PageViewItem> pageViewItems = [
    PageViewItem(
        umgURL: 'assets/images/onB1.png',
        title: 'Title On Boardring 1',
        body: 'Body On Boardring 1'),
    PageViewItem(
        umgURL: 'assets/images/onB2.png',
        title: 'Title On Boardring 2',
        body: 'Body On Boardring 2'),
    PageViewItem(
        umgURL: 'assets/images/onB3.png',
        title: 'Title On Boardring 3',
        body: 'Body On Boardring 3'),
  ];

  PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defultTextButton(
            onPressed: submit,
            lable: "skip",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageViewController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == pageViewItems.length - 1) {
                    setState(() {
                      isLast = true;
                      print('isLast is $isLast');
                    });
                  } else {
                    setState(() {
                      isLast = false;
                      print('isLast is $isLast');
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildPageViewItem(pageViewItems[index]),
                itemCount: 3,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageViewController, // PageController
                  count: pageViewItems.length,
                  effect: const ExpandingDotsEffect(
                    expansionFactor: 4,
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: Colors.grey,
                    activeDotColor: defultColor,
                  ), // your preferred effect
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageViewController.nextPage(
                        duration: const Duration(
                          milliseconds: 600,
                        ),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Row(
                    children: const [
                      Text("Next"),
                      SizedBox(width: 7.0),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CashHelper.setData(key: 'onBordering', value: true).then((value) {
      if (value) {
        navigateAndRemoveTo(context, const LoginScreen());
      }
    });
  }

  Widget buildPageViewItem(PageViewItem model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.umgURL),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            model.body,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      );
}

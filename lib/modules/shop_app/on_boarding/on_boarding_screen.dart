import 'package:bmi/modules/shop_app/login/shop_login_screen.dart';
import 'package:bmi/shared/components/components.dart';
import 'package:bmi/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();

  static void configure() {}
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'title 1',
      body: 'body 1',
    ),
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'title 2',
      body: 'body 2',
    ),
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'title 3',
      body: 'body 3',
    ),
  ];
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value==null) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'SKIP',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildingBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      dotWidth: 10.0,
                      spacing: 5,
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildingBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(child: Image.asset(model.image)),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          )
        ],
      );
}

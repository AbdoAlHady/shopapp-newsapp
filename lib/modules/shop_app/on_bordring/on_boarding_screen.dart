import 'package:bmicalc/modules/shop_app/login_screen/login_screen.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/networks/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';

class BoradingModel {
  final String image;
  final String title;
  final String body;

  BoradingModel({required this.image, required this.title, required this.body});

}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context: context, widget: ShopLoginScreen());
      }
    });
  }

  List<BoradingModel> boarding = [
    BoradingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoradingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 1 Body',
    ),
    BoradingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              function: submit,
              text: "SKIP",
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      print("last");
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      print(" not last");
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBroadingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBroadingItem(BoradingModel modal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(modal.image),
          ),
        ),
        Text(
          modal.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          modal.body,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

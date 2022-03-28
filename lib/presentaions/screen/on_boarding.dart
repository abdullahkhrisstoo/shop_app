// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:project1/constant/colors.dart';
import 'package:project1/constant/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../network/local/shared_pref_helper.dart';
import 'login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

var bordController = PageController();
bool isLast = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "LABEL APP",
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: PageView.builder(
        controller: bordController,
        onPageChanged: (int index) {
          if (model.length - 1 == index) {
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
        },
        itemBuilder: (context, index) =>
            onBoardingBuilder(model[index], context),
        itemCount: model.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}

class OnBoardingModel {
  final String image;
  final String description;
  OnBoardingModel({required this.description, required this.image});
}

List<OnBoardingModel> model = [
  OnBoardingModel(
      description:
          'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      image: 'assests/images/on_boarding_1.png'),
  OnBoardingModel(
      description:
          'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      image: 'assests/images/on_boarding_2.png'),
  OnBoardingModel(
      description:
          'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      image: 'assests/images/on_boarding_3.png'),
];

Widget onBoardingBuilder(OnBoardingModel onBoardingModel, context) {
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        navigatAndFinsh(context, LoginScreen());
      }
    });
  }

  return Column(
    children: [
      Image(
        image: AssetImage(onBoardingModel.image),
      ),
      SizedBox(
        height: 30,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          onBoardingModel.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              color: ConstantColor.secondeyColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Spacer(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: submit,
              child: Text(
                'SKIP',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ConstantColor.primaryColor),
              ),
            ),
            SmoothPageIndicator(
              controller: bordController,
              count: model.length,
              axisDirection: Axis.horizontal,
              effect: SlideEffect(
                  radius: 10.0,
                  paintStyle: PaintingStyle.stroke,
                  dotColor: Colors.grey,
                  activeDotColor: ConstantColor.primaryColor),
            ),
            TextButton(
              onPressed: () {
                if (isLast == true) {
                  submit();
                } else {
                  bordController.nextPage(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.decelerate);
                }
              },
              child: Text(
                'NEXT',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ConstantColor.primaryColor),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 40,
      ),
    ],
  );
}

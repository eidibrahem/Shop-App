import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/layout/news_app/news_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'android/assets/images/on_boarding5.jpg',
        body: 'online',
        title: 'Online Shopping'),
    BoardingModel(
        image: 'android/assets/images/work-04.jpg',
        body: 'now',
        title: 'Shopping Now'),
    BoardingModel(
        image: 'android/assets/images/work-07.jpg',
        body: 'stor',
        title: 'Official Store'),
  ];
  bool islast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value == true) {
        navigatAndFinsh(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageViewControter = PageController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              'SKIP',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: pageViewControter,
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    islast = true;
                  });
                } else {
                  setState(() {
                    islast = false;
                  });
                }
              },
              itemBuilder: ((context, index) =>
                  buildBoardingItme(boarding[index])),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller:pageViewControter,
               
                effect:ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,

                  dotHeight: 10
                ),
                 count: boarding.length),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (islast) {
                    submit();
                  }
                  pageViewControter.nextPage(
                      duration: Duration(milliseconds: 750),
                      curve: Curves.fastOutSlowIn);
                },
                child: Icon(Icons.arrow_forward_ios_sharp),
              )
            ],
          )
        ]),
      ),
    );  
  }

  Widget buildBoardingItme(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}

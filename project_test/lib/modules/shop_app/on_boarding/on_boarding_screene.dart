import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_test/modules/shop_app/on_boarding/shop_login_screen/shop_login.dart';
import 'package:project_test/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../networks/local/cache_helper.dart';
import '../../../styles/colors.dart';


class OnBoardingModel{

  final String? title;
  final String? body;
  final String? image;


  OnBoardingModel({
    required this.title,
    required this.body,
    required this.image,
});

}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardPageController = PageController();

  List<OnBoardingModel> OnBoardItems = [
    OnBoardingModel(
      title: 'ONBOARD TITLE 1',
      body: 'ONBOARD BODY 1',
      image: 'images/shop_photo_1.jpg'
    ),
    OnBoardingModel(
      title: 'ONBOARD TITLE 2',
      body: 'ONBOARD BODY 2',
      image: 'images/shop_photo_1.jpg'
    ),
    OnBoardingModel(
      title: 'ONBOARD TITLE 3',
      body: 'ONBOARD BODY 3',
      image: 'images/shop_photo_1.jpg'
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: (){
                submit();
              },
              child: Text(
                'SKIP',

              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index==OnBoardItems.length-1){
                    setState(() {
                      isLast = true;
                    });
                  }
                  else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: onBoardPageController,
                itemBuilder: (context,index) => buildBoardingItem(OnBoardItems[index]),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
                Expanded(
                  child: SmoothPageIndicator(
                    count: OnBoardItems.length,
                    controller: onBoardPageController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultcolor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: (){

                    if(isLast){
                      submit();
                    }
                    else{
                      onBoardPageController.nextPage(
                        duration: Duration(
                          milliseconds: 1000,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage(model.image!),
        ),
      ),
      Text(
        model.title!,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        model.body!,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );

  void navigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => widget,
      ),
          (route) => false);

  void submit(){
    CacheHelper.setData(key: 'onBoarding', value: true).then((value){
      navigateAndFinish(context, ShopLoginScreen());
    });

  }
}

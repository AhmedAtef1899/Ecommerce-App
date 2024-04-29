import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled1/shared/components.dart';
import 'package:untitled1/shared/local/cacheHelper.dart';

import 'login/login_screen.dart';

class boardModel{
  final String image;
  final String title;
  final String body;

  boardModel({ required this.image,required this.title,required this.body});
}

class onBoard extends StatefulWidget{

  @override
  State<onBoard> createState() => _onBoardState();
}

class _onBoardState extends State<onBoard> {
  var boardController = PageController();
  bool isLast = false;
  List<boardModel> boarding =
  [
    boardModel(
        image: 'https://images.pexels.com/photos/5076516/pexels-photo-5076516.jpeg?auto=compress&cs=tinysrgb&w=600',
        title: 'On Board 1 title',
        body: 'On Board 1 Body'
    ),
    boardModel(
        image: 'https://images.pexels.com/photos/5947552/pexels-photo-5947552.jpeg?auto=compress&cs=tinysrgb&w=600',
        title: 'On Board 2 title',
        body: 'On Board 2 Body'
    ),

    boardModel(
        image: 'https://images.pexels.com/photos/5614119/pexels-photo-5614119.jpeg?auto=compress&cs=tinysrgb&w=600',
        title: 'On Board 3 title',
        body: 'On Board 3 Body'
    ),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            // CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
            //   if (value)
            //   {
            //
            //   }
            //
            // });
            navigateAndFinish(context, LoginScreen());
          }, child: const Text(
              'SKIP'
          ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index) => boardItem(boarding[index]),
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if (index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children:  [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 5,
                  ) ,
                ),
                const Spacer(),
                FloatingActionButton(onPressed: (){
                  if (isLast)
                  {
                    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
                      if (value)
                      {
                        navigateAndFinish(context, LoginScreen());
                      }
                    });

                  }
                  else
                  {
                    boardController.nextPage(duration:
                    const Duration(
                      milliseconds: 750,
                    ),
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  }
                },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  backgroundColor: Colors.deepOrange,
                )
              ],
            )
          ],
        ),
      ) ,
    );
  }

  Widget boardItem(boardModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:   [
      Expanded(
          child: Image(
        image: NetworkImage(model.image),)
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        model.title,
        style: const TextStyle(
            fontSize: 24
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        model.body,
        style: const TextStyle(
            fontSize: 14
        ),
      )
    ],
  );
}

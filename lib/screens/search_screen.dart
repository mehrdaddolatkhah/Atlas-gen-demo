import 'package:flutter/material.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import 'package:atlas_gen_demo/screens/show_user_details.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import 'package:flushbar/flushbar.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  final nationalIdController = TextEditingController();

  void showFlushBar(BuildContext context, String title, String text) {
    Flushbar(
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.purple.shade800, Colors.purpleAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black,
          offset: Offset(3, 3),
          blurRadius: 3,
        )
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      titleText: Text(
        title,
        style: TextStyle(fontFamily: 'mainBold', color: Colors.white),
      ),
      messageText: Text(
        text,
        style: TextStyle(fontFamily: 'mainMedium', color: Colors.white),
      ),
      duration: Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('جستجو میان کاربران'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/search.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                child: FadeAnimation(
                    1.8,
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            "جستجو براساس کد ملی",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'persianBold',
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            )),
                            child: TextFormField(
                              controller: nationalIdController,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "کد ملی",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: 'persianMedium',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        InkWell(
                          onTap: () {
                            if (nationalIdController.text != "") {
                              Navigator.of(context).pushNamed(
                                  ShowUserDetailsScreen.routeName,
                                  arguments: {
                                    'nationalId': nationalIdController.text,
                                  });
                            } else {
                              showFlushBar(
                                  context, "خطا", "کد ملی را وارد نمایید");
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, .4),
                                  Color.fromRGBO(143, 148, 251, .8),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "جستجو",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'persianBold',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:atlas_gen_demo/data/storage/db_helper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import 'package:atlas_gen_demo/screens/login_screen.dart';
import '../models/user.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  validate(BuildContext ctx) async {
    if (usernameController.text != "" && passwordController.text != "") {
      final dbHelper = DBHelper();
      User user = User(null, null, null, usernameController.text,
          passwordController.text, null, null, null);
      await dbHelper.save(user);
      navigateToRegister(ctx);
    } else {
      showFlushBar(ctx, "خطا", "اطلاعات را وارد نمایید");
    }
  }

  void navigateToRegister(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      LoginScreen.routeName,
    );
  }

  void showFlushBar(BuildContext context, String title, String text) {
    Flushbar(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
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
        textAlign: TextAlign.right,
      ),
      messageText: Text(
        text,
        style: TextStyle(fontFamily: 'mainMedium', color: Colors.white),
        textAlign: TextAlign.right,
      ),
      duration: Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/register.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              FadeAnimation(
                  1.8,
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          "ثبت نام در برنامه",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'persianBold',
                          ),
                        ),
                      ),
                    ),
                  )),
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
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(color: Colors.grey[100]),
                              )),
                              child: TextFormField(
                                controller: usernameController,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                                // validator: (val) => val.length == 0
                                //     ? 'نام کاربری را وارد نمایید.'
                                //     : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "نام کاربری",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontFamily: 'persianMedium',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: passwordController,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                obscureText: true,
                                // validator: (val) => val.length == 0
                                //     ? 'رمز عبور را وارد نمایید.'
                                //     : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "کلمه عبور",
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      InkWell(
                        onTap: () => validate(context),
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
                              "ثبت نام در برنامه",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'persianBold',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

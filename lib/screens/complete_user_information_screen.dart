import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:atlas_gen_demo/data/storage/db_helper.dart';
import 'package:atlas_gen_demo/screens/users_list_screen.dart';

class CompleteUserInformationScreen extends StatelessWidget {
  static const routeName = '/complete-user-information';

  final nameController = TextEditingController();
  final familyController = TextEditingController();
  final nationalIdController = TextEditingController();
  final mobileController = TextEditingController();

  var id;
  var birthday;

  validate(BuildContext ctx) async {
    if (nameController.text != "" &&
        familyController.text != "" &&
        nationalIdController.text != "" &&
        mobileController.text != "") {
      final dbHelper = DBHelper();

      dbHelper.update(
          id.toString(),
          nameController.text,
          familyController.text,
          birthday.toString(),
          mobileController.text,
          nationalIdController.text);

      navigateToUsersList(ctx);
    } else {
      showFlushBar(ctx, "خطا", "اطلاعات را وارد نمایید");
    }
  }

  void navigateToUsersList(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      UsersListScreen.routeName,
    );
  }

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
    final dynamic rcvdData = ModalRoute.of(context).settings.arguments;
    var userId = rcvdData['id'];

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
                    image: AssetImage('assets/images/complete_profile.png'),
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
                            "تکمیل اطلاعات",
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
                              controller: nameController,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "نام",
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
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            )),
                            child: TextFormField(
                              controller: familyController,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "نام خانوادگی",
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
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            )),
                            child: TextFormField(
                              controller: nationalIdController,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
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
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            )),
                            child: TextFormField(
                              controller: mobileController,
                              textAlign: TextAlign.right,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "09123456789",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: 'persianMedium',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(1250, 1, 1),
                                    maxTime: DateTime(1450, 12, 31),
                                    onChanged: (date) {
                                  print('change $date');
                                }, onConfirm: (date) {
                                  birthday = date;
                                  print('confirm $date');
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.fa);
                              },
                              child: Text(
                                'تاریخ تولد',
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2,
                      InkWell(
                        onTap: () => {
                          id = userId,
                          validate(context),
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
                              "تکمیل اطلاعات",
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

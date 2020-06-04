import 'package:flutter/material.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import 'package:atlas_gen_demo/data/storage/db_helper.dart';

import '../models/user.dart';

import 'package:atlas_gen_demo/screens/users_list_screen.dart';

class ShowUserDetailsScreen extends StatelessWidget {
  static const routeName = '/show-user-details';
  var dbHelper;
  var nationalId;
  Future<User> user;

  getUserData(String id) {
    dbHelper = DBHelper();
    user = dbHelper.getUser(id);
  }

  userData(BuildContext ctx) {
    return Expanded(
      child: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return showData(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'کاربری با این کد ملی در سیستم وجود ندارد',
                style: TextStyle(
                  fontFamily: 'persianBold',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Column showData(User user) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[100]),
          )),
          child: Text(
            "نام :  ${user.name}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[100]),
          )),
          child: Text(
            "نام خانوادگی :  ${user.family}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[100]),
          )),
          child: Text(
            "نام کاربری :  ${user.username}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[100]),
          )),
          child: Text(
            "رمز عبور :  ${user.password}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[100]),
          )),
          child: Text(
            "شماره موبایل :  ${user.mobile}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey[100]),
          )),
          child: Text(
            "تاریخ تولد :  ${user.birthday}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "شماره شناسنامه :  ${user.nationalId}",
            style: TextStyle(
              fontFamily: 'persianMedium',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void navigateToRegister(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      UsersListScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamic rcvdData = ModalRoute.of(context).settings.arguments;
    nationalId = rcvdData['nationalId'];
    getUserData(nationalId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('مشخصات کاربر'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/show_user_details.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                child: FadeAnimation(
                    1.8,
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          "اطلاعات کاربر",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'persianBold',
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
                      child: userData(context),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        InkWell(
                          onTap: () => navigateToRegister(context),
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
                                "بازگشت به لیست کاربران",
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

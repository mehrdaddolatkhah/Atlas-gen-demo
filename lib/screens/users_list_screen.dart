import 'package:atlas_gen_demo/data/storage/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import '../models/user.dart';
import 'package:flushbar/flushbar.dart';

class UsersListScreen extends StatefulWidget {
  static const routeName = '/users-list-screen';

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  Future<List<User>> usersList;
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();

    refreshList();
  }

  refreshList() {
    setState(() {
      usersList = dbHelper.getUsers();
    });
  }

  SingleChildScrollView dataTable(List<User> users) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('کد ملی'),
          ),
          DataColumn(
            label: Text('نام کاربری'),
          ),
          DataColumn(
            label: Text('id'),
          ),
        ],
        rows: users
            .map(
              (user) => DataRow(cells: [
                DataCell(Text(user.nationalId != null
                    ? user.nationalId
                    : "اطلاعات تکمیل نشده")),
                DataCell(Text(user.username)),
                DataCell(Text(user.id.toString())),
              ]),
            )
            .toList(),
      ),
    );
  }

  userList(BuildContext ctx) {
    return Expanded(
      child: FutureBuilder(
        future: usersList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //showFlushBar(ctx, "test", snapshot.data);
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text(
              '"No Data Found',
            );
          }

          return CircularProgressIndicator();
        },
      ),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/users_list.png'),
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
                          "لیست کاربران سیستم",
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
            userList(context)
          ],
        ),
      ),
    );
  }
}

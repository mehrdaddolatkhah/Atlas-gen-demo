import 'package:atlas_gen_demo/data/storage/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:atlas_gen_demo/Animation/FadeAnimation.dart';
import '../models/user.dart';
import 'package:flushbar/flushbar.dart';
import 'package:atlas_gen_demo/screens/complete_user_information_screen.dart';
import 'package:atlas_gen_demo/screens/show_user_details.dart';
import 'package:atlas_gen_demo/screens/search_screen.dart';

class UsersListScreen extends StatefulWidget {
  static const routeName = '/users-list-screen';

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  Future<List<User>> usersList;
  var dbHelper;
  var selectedId;

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
            label: Text('شناسه'),
          ),
        ],
        rows: users
            .map(
              (user) => DataRow(cells: [
                DataCell(
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          selectedId = user.id;
                          navigateToCompleteUserInformation(context);
                        },
                      ),
                      Text(
                        user.nationalId != null
                            ? user.nationalId
                            : "تکمیل نشده",
                      ),
                    ],
                  ),
                  onTap: () {
                    if (user.nationalId != null) {
                      Navigator.of(context).pushNamed(
                          ShowUserDetailsScreen.routeName,
                          arguments: {
                            'nationalId': user.nationalId,
                          });
                    }
                  },
                ),
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

  void navigateToCompleteUserInformation(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(CompleteUserInformationScreen.routeName, arguments: {
      'id': selectedId,
    });
  }

  void navigateToSearch(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(SearchScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Atlas Gen Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                SearchScreen.routeName,
              );
            },
          )
        ],
        leading: new IconButton(
          icon: new Icon(Icons.ac_unit),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/users_list.png'),
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
            userList(context)
          ],
        ),
      ),
    );
  }
}

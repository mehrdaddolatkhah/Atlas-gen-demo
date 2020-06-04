import 'package:atlas_gen_demo/screens/register_screen.dart';
import 'package:atlas_gen_demo/screens/users_list_screen.dart';
import 'package:atlas_gen_demo/screens/complete_user_information_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

final routes = {
  '/': (ctx) => LoginScreen(),
  RegisterScreen.routeName: (ctx) => RegisterScreen(),
  LoginScreen.routeName: (ctx) => LoginScreen(),
  UsersListScreen.routeName: (ctx) => UsersListScreen(),
  CompleteUserInformationScreen.routeName: (ctx) =>
      CompleteUserInformationScreen(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'persianMain',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'persianMedium',
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}

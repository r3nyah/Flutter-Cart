import 'package:flutter/material.dart';
import 'package:food_ordering/common/assets.dart';
import 'package:food_ordering/common/provider.dart';
import 'package:food_ordering/presentation/cart_screen.dart';
import 'package:food_ordering/presentation/homepage.dart';
import 'package:food_ordering/presentation/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  Globals.data = pref.getBool('data') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (context){
            return CartProvider();
          },
        )
      ],
      builder: (context,child){
        return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.green,
              primary: Colors.green
            )
          ),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          initialRoute: 'splash_screen',
          routes: {
            '/' : (context) => Homepage(),
            'splash_screen' : (context) => IntroPage(),
            'cart_screen' : (context) => CartScreen()
          },
        );
      },
    )
  );
}
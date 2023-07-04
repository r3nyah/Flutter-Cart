import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/presentation/chat_screen.dart';
import 'package:food_ordering/presentation/favorite.dart';
import 'package:food_ordering/presentation/notification_screen.dart';
import 'package:food_ordering/presentation/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => HomepageState();
}
late TabController tabController;
int initialTabIndex = 1;


class HomepageState extends State<Homepage> with TickerProviderStateMixin{
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }
  int selected = 0;
  PageController pageController = PageController();
  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.all(6),
              height: height * 0.03,
              width: width * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/image/profile.jpg"
                  ),
                  fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(width: 2,)
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFF48BF53),
              ),
              SizedBox(width: width * 0.01,),
              Text(
                "Indonesia",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  )
                ),
              )
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF48BF53),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.menu_rounded,color: Colors.white,),
            ),
          ),
        ),
        body: PageView(
          onPageChanged: (val){
            pageController.jumpToPage(val);
            setState(() {
              selected = val;
            });
          },
          controller: pageController,
          children: [
            ProductScreen(),
            ChatScreen(),
            Notifications(),
            Favorite(),
          ],
        ),
        floatingActionButton: Align(
          alignment: Alignment(0.12,1.03),
          child: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(
                context,
                'cart_screen'
              );
            },
            backgroundColor: Colors.green,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0)
              )
            ),
            child: const Icon(
              CupertinoIcons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2_fill),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart_fill),
              label: 'Favorite',
            ),
          ],
          currentIndex: selected,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Color(0xFF48BF53),
          onTap: (index){
            pageController.jumpToPage(index);
            setState(() {
              selected = index;
            });
          },
        ),
      ),
    );
  }
}

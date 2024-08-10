import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }

}
class _TabsScreen extends State<TabsScreen>{

  int currentIndex = 0;

  final List<Widget> screen = [

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(0.7),

        title: Text('Agri AI Connect',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),


        leading: IconButton(onPressed: () =>Navigator.push(
          context, MaterialPageRoute(
          builder: (ctx) => Profile(),
        ),
        ),
          icon: Icon(Icons.person, size: 35,),
        ),
        actions: [
          IconButton(onPressed: () {},
            icon: Icon(Icons.notifications, size: 35,),
          ),
        ],
      ),
      body: screen[currentIndex],
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          currentIndex = 0;
        });
      },
        child: Icon(Icons.home, ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.greenAccent.withOpacity(0.7),
        shape: CircularNotchedRectangle(),
        notchMargin: 7.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              setState(() {
                currentIndex = 1;
              });
            },
              icon: ImageIcon(AssetImage('lib/assets/Icons/target.png'),),
            ),
            IconButton(onPressed: (){
              setState(() {
                currentIndex = 2;
              });
            },
              icon: ImageIcon(AssetImage('lib/assets/Icons/reward.png'),),
            ),
            IconButton(onPressed: (){
              setState(() {
                currentIndex = 3;
              });
            },
              icon: ImageIcon(AssetImage('lib/assets/Icons/investment.png'),),
            ),
            IconButton(onPressed: (){
              setState(() {
                currentIndex = 4;
              });
            },
              icon: ImageIcon(AssetImage('lib/assets/Icons/shopping.png'),),
            ),
          ],
        ),


      ),
    );
  }


}
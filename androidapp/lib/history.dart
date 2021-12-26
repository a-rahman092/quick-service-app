import 'package:flutter/material.dart';  
import './pendingorders.dart';  
import './completedorders.dart';  
  
void main() => runApp(History());  
  
class History extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: DefaultTabController(  
        
        length: 2,  
        child: Scaffold(  
          appBar: AppBar(  
            title: Text('Quick Service'), 
            backgroundColor: Colors.indigo[900], 
            bottom: TabBar(  
              tabs: [  
                Tab(text: "Pending Orders"),  
                Tab(text: "Completed Orders")  
              ],  
            ),  
          ),  
          body: TabBarView(  
            children: [  
              PendingOrders(),  
              CompletedOrders(),  
            ],  
          ),  
        ),  
      ),  
      debugShowCheckedModeBanner: false,
    );  
  }  
}  
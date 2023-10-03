import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:legal_ease/navbar/appointments.dart';
import 'package:legal_ease/navbar/clientdash.dart';
import 'package:legal_ease/navbar/clientprofile.dart';
import 'package:legal_ease/navbar/homeadv.dart';
import 'package:legal_ease/navbar/homepage1.dart';
import 'package:legal_ease/navbar/spotlight.dart';
import 'package:legal_ease/providers/user_provider.dart';
import 'package:provider/provider.dart';


class navbar1 extends StatefulWidget {
  const navbar1({super.key});

  @override
  State<navbar1> createState() => _navbar1State();
}

class _navbar1State extends State<navbar1> {
  @override
  Widget build(BuildContext context) {
    String role =Provider.of<UserProvider>(context).getrole;
    return role!="Client" ? homeadv() : clientdash();
  }
}

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
    homepage(),
    spotlight(),
    appointpage(),
    clientprofile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 5),
          child: GNav(
            haptic: true,
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
            
               tabActiveBorder: Border.all(color: Colors.white),
          

            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: const [
            GButton(icon: CupertinoIcons.home,
            text: "Home",
          
            
            ),
            GButton(icon: Icons.info,
            text: "Spotlight",
            ),
            GButton(icon: Icons.schedule,
            text: "History",
            ),
            GButton(icon: Icons.perm_identity_sharp,
            text: "Profile",
            ),
            
              
          ],
          
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
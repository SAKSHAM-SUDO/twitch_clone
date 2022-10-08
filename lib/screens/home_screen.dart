import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/screens/feed_screen.dart';
import 'package:twitch_clone/screens/go_live_screen.dart';
import 'package:twitch_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  List<Widget> pages = [
    const FeedScreen(),
    const Center(
      child: Text('Browser'),
    )
  ];
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: buttonColor,
          unselectedItemColor: primaryColor,
          backgroundColor: backgroundColor,
          onTap: onPageChanged,
          unselectedFontSize: 12,
          currentIndex: _page,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Following'),
            BottomNavigationBarItem(icon: Icon(Icons.copy), label: 'Browse'),
          ]),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: 34,
                      onPressed: () {},
                      icon: Icon(Icons.account_circle_sharp)),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notification_add)),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GoLiveScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(children: [
                                Icon(
                                  Icons.start,
                                  size: 14,
                                ),
                                SizedBox(width: 5),
                                Text('Create',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold))
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: pages[_page]),
          ],
        ),
      ),
    );
  }
}

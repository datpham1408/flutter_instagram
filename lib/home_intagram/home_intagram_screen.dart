import 'package:flutter/material.dart';
import '../add_new/add_new_screen.dart';
import '../model/user_instagram_model.dart';
import '../profile/profile_instagram.dart';
import '../rells/rells_screen.dart';
import '../search/search_screen.dart';
import 'home_instagram_new_screen.dart';

class HomeInstagramScreen extends StatefulWidget {
  final UserInstagramModel user;

  const HomeInstagramScreen({super.key, required this.user});

  @override
  State<HomeInstagramScreen> createState() => _HomeInstagramScreenState();
}

class _HomeInstagramScreenState extends State<HomeInstagramScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [];

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: PageView(),
        child: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: itemBottomBar(),
    );
  }

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeInstagramNewScreen(),
      SearchScreen(),
      AddNewScreen(),
      RellsScreen(),
      ProfileInstagramScreen(userInstagramModel: widget.user,),
    ]);
    _pageController = PageController(initialPage: _currentIndex);

    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  Widget itemBottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.home,color: Colors.black,),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search,color: Colors.black),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined,color: Colors.black),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library_rounded,color: Colors.black),
            label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined,color: Colors.black),
            label: ''
        ),
      ],
    );
  }
}

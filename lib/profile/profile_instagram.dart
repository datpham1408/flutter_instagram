import 'package:flutter/material.dart';

import '../model/data.dart';
import '../model/user_instagram_model.dart';
import '../resources/images.dart';
import '../resources/utils.dart';

class ProfileInstagramScreen extends StatefulWidget {
  final UserInstagramModel? userInstagramModel;

  const ProfileInstagramScreen({super.key, required this.userInstagramModel});

  @override
  State<ProfileInstagramScreen> createState() => _ProfileInstagramScreenState();
}

class _ProfileInstagramScreenState extends State<ProfileInstagramScreen> {
  List<ListItem> items = [
    ListItem('ĐN', imageVegetable),
    ListItem('Đl', imageSpinach),
    ListItem('Mới', imagePlus),
  ];

  int _currentIndex = 0;
  final List<Widget> _screens = [];

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _screens.addAll([]);
  }

  @override
  Widget build(BuildContext context) {
    return itemBody();
  }

  Widget itemBody() {
    return Column(
      children: [
        itemAppbar(),
        itemProfile(),
        Container(
          margin: EdgeInsets.all(8),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.userInstagramModel?.userName ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.all(4),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Image.asset(
                  imageThreads,
                  height: 20,
                  width: 20,
                ),
                Utils.instance.sizeBoxWidth(4),
                Text(widget.userInstagramModel?.userName ?? ''),
              ],
            ),
          ),
        ),
        itemTool(),
        itemStory(),
        // itemAlbum(),
      ],
    );
  }

  Widget itemTool() {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.3,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text('Chỉnh sửa')),
          ),
          Utils.instance.sizeBoxWidth(8),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.5,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text('Chia sẻ trang cá nhân')),
          ),
          Utils.instance.sizeBoxWidth(8),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.1,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              imageInvite,
              height: 15,
              width: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAppbar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                widget.userInstagramModel?.userName ?? '',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Utils.instance.sizeBoxWidth(4),
              const Text(
                'v',
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                imageThreads,
              ),
              Utils.instance.sizeBoxWidth(16),
              Icon(Icons.add_box_outlined),
              Utils.instance.sizeBoxWidth(16),
              Image.asset(imageMenu),
            ],
          )
        ],
      ),
    );
  }

  Widget itemProfile() {
    return Row(
      children: [
        itemAvatar(),
        Utils.instance.sizeBoxWidth(8),
        itemDetailProfileAvatar()
      ],
    );
  }

  Widget itemAvatar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360), color: Colors.grey),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Image.asset(
                imageGoat,
                height: 70,
                width: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDetailProfileAvatar() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          itemDetailProfile(quantity: '2', title: 'bài viết'),
          itemDetailProfile(quantity: '118', title: 'người theo dõi'),
          itemDetailProfile(quantity: '2', title: 'bài viết'),
        ],
      ),
    );
  }

  Widget itemDetailProfile({String? quantity, String? title}) {
    return Column(
      children: [
        Text(
          quantity ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Utils.instance.sizeBoxHeight(4),
        Text(title ?? ''),
      ],
    );
  }

  Widget itemStory() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              ListItem item = items[index];
              return itemDetailStory(item.imageUrl, item.name);
            }),
      ),
    );
  }

  Widget itemDetailStory(String image, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                border: Border.all(color: Colors.grey)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Image.asset(
                image,
                height: 50,
                width: 50,
              ),
            ),
          ),
          Utils.instance.sizeBoxHeight(4),
          Text(name)
        ],
      ),
    );
  }

//   Widget itemAlbum() {
//     return Column(
//       children: [
//         itemBottomBar(),
//         PageView(
//           controller: _pageController,
//           children: _screens,
//         ),
//       ],
//     );
//   }
//
//   Widget itemBottomBar() {
//     return BottomNavigationBar(
//       currentIndex: _currentIndex,
//       onTap: (index) {
//         setState(() {
//           _currentIndex = index;
//           _pageController.jumpToPage(index);
//         });
//       },
//       items: const [
//         BottomNavigationBarItem(
//           backgroundColor: Colors.white,
//           icon: Icon(Icons.home),
//           label: 'Trang Chủ',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart),
//           label: 'Đơn Hàng',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.message),
//           label: 'Tin Nhắn',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle_outlined),
//           label: 'Cá Nhân',
//         ),
//       ],
//     );
//   }
// }
}

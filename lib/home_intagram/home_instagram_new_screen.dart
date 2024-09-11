import 'package:flutter/material.dart';

import '../model/data.dart';
import '../resources/images.dart';
import '../resources/utils.dart';

class HomeInstagramNewScreen extends StatefulWidget {
  const HomeInstagramNewScreen({Key? key}) : super(key: key);

  @override
  State<HomeInstagramNewScreen> createState() => _HomeInstagramNewScreenState();
}

class _HomeInstagramNewScreenState extends State<HomeInstagramNewScreen> {
  List<ListItem> items = [
    ListItem('Item 1', imageVegetable),
    ListItem('Item 2', imageSpinach),
    ListItem('Item 3', imageKale),
    ListItem('Item 4', imageWatercress),
    ListItem('Item 5', imageCabbage),
    ListItem('Item 6', imageAsparagus),
  ];
  List<ListItem> itemsNew = [
    ListItem('Item 1', imageVegetable),
    ListItem('Item 2', imageSpinach),
    ListItem('Item 3', imageKale),
    ListItem('Item 4', imageWatercress),
    ListItem('Item 5', imageCabbage),
    ListItem('Item 6', imageAsparagus),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CustomScrollView(
        slivers:[
          SliverAppBar(
            expandedHeight: 200.0,
            // pinned: true,
            floating: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title:  Column(
                children: [
                  Utils.instance.sizeBoxHeight(16),
                  itemAppbar(),
                  Align(
                    alignment: Alignment.topLeft,
                      child: itemStory()),
                ],
              ),
            ),

          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                ListItem item = itemsNew[index];
                return itemDetailArticles(item.imageUrl, item.name);
              },
              childCount: itemsNew.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBody() {
    return Column(
      children: [
        // itemAppbar(),
        // itemStory(),

        itemArticles()
      ],
    );
  }

  Widget itemAppbar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Instagram',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
          ),
          Row(
            children: [
              Image.asset(imageHeart,height: 12,width: 12,),
              Utils.instance.sizeBoxWidth(16),
              Image.asset(imageMessenger,height: 12,width: 12,),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemStory() {
    return Container(
      height: 50,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            ListItem item = items[index];
            return itemDetailStory(item.imageUrl, item.name);
          }),
    );
  }

  Widget itemDetailStory(String image, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                border: Border.all(color: Colors.pink)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Image.asset(
                image,
                height: 20,
                width: 20,
              ),
            ),
          ),
          Text(name,style: TextStyle(fontSize: 12,color: Colors.black),)
        ],
      ),
    );
  }

  Widget itemArticles() {
    return Column(
      children: [
        const Divider(
          thickness: 0.1,
          color: Colors.grey,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itemsNew.length,
            itemBuilder: (context, index) {
              ListItem item = itemsNew[index];
              return itemDetailArticles(item.imageUrl, item.name);
            },
          ),
        ),
      ],
    );
  }

  Widget itemDetailArticles(String image, String name) {
    return Container(
      child: Column(
        children: [
          itemAvatar(name, image),
          itemImage(image),
          itemFeeling(),
        ],
      ),
    );
  }

  Widget itemAvatar(String name, String image) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    color: Colors.grey.shade300),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Image.asset(
                    image,
                  ),
                ),
              ),
              Utils.instance.sizeBoxWidth(16),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Image.asset(imageOption),
        ],
      ),
    );
  }

  Widget itemImage(String image) {
    return Container(
        color: Colors.grey,
        height: 280,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(image));
  }

  Widget itemFeeling() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageHeart),
              Utils.instance.sizeBoxWidth(24),
              Image.asset(imageSpeech),
              Utils.instance.sizeBoxWidth(24),
              Image.asset(imageSend),
            ],
          ),
          Image.asset(imageBookmark),
        ],
      ),
    );
  }
}

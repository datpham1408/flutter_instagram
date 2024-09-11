import 'package:flutter/material.dart';

import '../resources/utils.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return itemBody();
  }

  Widget itemBody(){
    return Column(
      children: [
        itemSearch(),
      ],
    );
  }
  Widget itemSearch(){
    return Container(
      height: 40,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Utils.instance.sizeBoxWidth(8),
          Icon(Icons.search),
          Utils.instance.sizeBoxWidth(8),
          Flexible(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

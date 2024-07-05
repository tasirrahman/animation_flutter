// ignore_for_file: must_be_immutable

import 'package:animation_flutter/animation_example.dart';
import 'package:animation_flutter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double height = 400;

  double height2 = 700;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = ['Item 0', 'Item 1', 'Item 2'];

  void _addItem() {
    final int newIndex = _items.length;
    _items.add('Item $newIndex');
    _listKey.currentState?.insertItem(newIndex);
  }

  void _removeItem(int index) {
    final String removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              int index = _items.indexOf(item);
              _removeItem(index);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
          Expanded(child: AnimationExample()),
          Expanded(child: HomePage()),
        ],
      ),
    );
  }
}

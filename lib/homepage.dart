import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<GridItem> items = List.generate(
    10,
    (index) => GridItem(
      title: 'Item $index',
      icon: Icons.star,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Grid View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AnimatedGridItem(item: items[index], index: index);
          },
        ),
      ),
    );
  }
}

class GridItem {
  final String title;
  final IconData icon;

  GridItem({required this.title, required this.icon});
}

class AnimatedGridItem extends StatefulWidget {
  final GridItem item;
  final int index;

  const AnimatedGridItem({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  _AnimatedGridItemState createState() => _AnimatedGridItemState();
}

class _AnimatedGridItemState extends State<AnimatedGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(item: widget.item, index: widget.index),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'hero-${widget.index}',
                child: Icon(widget.item.icon, size: 50),
              ),
              SizedBox(height: 10),
              Hero(
                tag: 'title-hero-${widget.index}',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(widget.item.title),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final GridItem item;
  final int index;

  const DetailScreen({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero-$index',
              child: Icon(item.icon, size: 150),
            ),
            SizedBox(height: 20),
            Hero(
              tag: 'title-hero-$index',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

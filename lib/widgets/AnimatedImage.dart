import 'package:flutter/material.dart';

class AnimatedThumbnail extends StatefulWidget {
  const AnimatedThumbnail({Key? key, required this.imageUrl}) : super(key: key);
  final imageUrl;

  @override
  _AnimatedThumbnailState createState() => _AnimatedThumbnailState();
}

class _AnimatedThumbnailState extends State<AnimatedThumbnail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 0.19),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          child: Image.network(widget.imageUrl),
        ),
      ),
    );
  }
}

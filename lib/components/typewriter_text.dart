import 'package:flutter/material.dart';
import 'package:rashid/constants/global.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration typingDuration;
  final TextStyle style;

  const TypewriterText({
    Key? key,
    required this.text,
    this.typingDuration = const Duration(milliseconds: 75),
    required this.style,
  }) : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds:
              typingTextLength * widget.typingDuration.inMilliseconds),
    );
    _animation = IntTween(begin: 0, end: typingTextLength).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: myBoolean,
        builder: (BuildContext context, bool value, Widget? child) {
          if(value){
            if(_controller.isAnimating){
              _controller.dispose();
            }
            _controller = AnimationController(
            vsync: this,
            duration: Duration(
                milliseconds:
                    typingTextLength * widget.typingDuration.inMilliseconds),
          );
          _animation =
              IntTween(begin: 0, end: typingTextLength).animate(_controller);
          _controller.forward();
          }
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, something) {
              return Container(
                // Wrap Text in a Container
                child: Text(
                  widget.text.substring(0, _animation.value),
                  style: widget.style,
                ),
              );
            },
          );
        });
  }
}

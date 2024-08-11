import 'package:flutter/material.dart';
import 'package:rashid/screens/home/components/silent_bot.dart';
import 'package:rashid/screens/home/components/speaking_bot.dart';

import '../../../constants/global.dart';

class MovingBot extends StatefulWidget {
  const MovingBot({super.key});

  @override
  State<MovingBot> createState() => _MovingBotState();
}

class _MovingBotState extends State<MovingBot>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController _controller;
  late Animation<double> _animation;
  double deltaX = 20;
  Curve curve = Curves.bounceOut;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});

      });
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  double shake(double value) =>
      2 * (0.5 - (0.5 - curve.transform(value)).abs());
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, deltaX * shake(controller.value)),
        child: child,
      ),
      child: ValueListenableBuilder<bool>(
      valueListenable: myBoolean,
      builder: (BuildContext context, bool value, Widget? child) {
        
          
          
        
        return value? SpeakingBot(animation: _animation):SilentBot();
      },
    )
    );
  }
}

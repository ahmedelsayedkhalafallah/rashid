import 'package:flutter/material.dart';
import 'package:rashid/screens/home/components/silent_bot.dart';
import 'package:rashid/screens/home/components/speaking_bot.dart';

import '../../../constants/global.dart';

class MovingCard extends StatefulWidget {
  final Function()? onTap;
  final String imagePath;
  final String cardText;
  final double width;
  final double height;
  final bool movingUp;
  const MovingCard({super.key, required this.movingUp, required this.onTap, required this.imagePath, required this.cardText,required  this.width,required  this.height});

  @override
  State<MovingCard> createState() => _MovingCardState();
}

class _MovingCardState extends State<MovingCard>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double deltaX = 20;
  late Curve curve ;

  @override
  void initState() {
    super.initState();
    curve =widget.movingUp? Curves.bounceOut: Curves.bounceIn;
    controller = AnimationController(
      duration: Duration(seconds: widget.movingUp? 20: 30),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });

    
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double shake(double value) =>
      2 * (0.5 - (0.5 - curve.transform(value)).abs());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, deltaX * shake(controller.value)),
          child: child,
        ),
        child: Container(
          height: widget.height *1.1,
          width: widget.width * 1.1,
          child: Stack(
            children: [
              
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(24.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [colorScheme(context).surface, Colors.white],
                    ),
                  ),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.cardText),
                  )),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    height: mediaQueryHeight(context)*.05,
                    width: mediaQueryHeight(context)*.05,
                    child: Image.asset(widget.imagePath,)),
                
              ),
            ],
          ),
        )
      ),
    );
  }
}

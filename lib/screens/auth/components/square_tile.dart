import 'package:flutter/material.dart';

import '../../../constants/global.dart';

class SquareTile extends StatefulWidget {
  final String imagePath;
  final String title;
  final Function()? fun;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.fun
  });

  @override
  State<SquareTile> createState() => _SquareTileState();
}

class _SquareTileState extends State<SquareTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.fun,
      child: Container(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Image.asset(
              widget.imagePath,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const SizedBox(width: 20),
            Text(widget.title,
                style:  TextStyle(fontSize:isArabic()? 20:18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
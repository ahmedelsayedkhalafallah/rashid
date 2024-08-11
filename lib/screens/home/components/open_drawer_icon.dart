import 'package:flutter/material.dart';

class ActionIcon extends StatefulWidget {
   IconData? iconData = Icons.menu;
  final Function()? onTap;
   ActionIcon({super.key, this.onTap, this.iconData});

  @override
  State<ActionIcon> createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            height: MediaQuery.of(context).size.width * .1,
            width: MediaQuery.of(context).size.width * .1,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * .01)),
            child: Icon(
              widget.iconData,
              size: MediaQuery.of(context).size.width * .07,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}

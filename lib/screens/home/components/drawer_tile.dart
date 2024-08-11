import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
  final IconData iconData;
  final String text;
  final Function() onPress;
  const DrawerTile({super.key, required this.iconData, required this.text, required this.onPress});

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(12),
    child: GestureDetector(
      onTap: widget.onPress,
      child: Row(
        children: [
          Icon(widget.iconData, color: Theme.of(context).colorScheme.secondary,size: MediaQuery.of(context).size.width * .05,),
          SizedBox(width: MediaQuery.of(context).size.width * .05,),
          Text(widget.text, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: MediaQuery.of(context).size.width * .05),)
        ],
      ),
    ) ,
    );
  }
}
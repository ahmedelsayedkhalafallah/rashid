import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {

  final Function()? fun;
  final String text;
  final Color? color;
  final EdgeInsets? edgeInsets;
  final Widget? widget;
  const MyButton({super.key,  required this.fun, required this.text, this.color,this.edgeInsets, this.widget});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: widget.fun,
                child: Container(
                  height: 58,
                  padding: widget.edgeInsets?? EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: widget.color?? Theme.of(context).colorScheme.secondary,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                                          ),
                        widget.widget ??Container()
                      ],
                    ),
                  )
                ),
              ),
            );
  }
}
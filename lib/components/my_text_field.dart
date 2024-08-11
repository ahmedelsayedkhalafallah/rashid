import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool autoFocus;
  final bool inputBorder;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorMsg,
      this.onChanged,
      this.inputFormatters,
      this.borderRadius,
      this.padding,
      this.autoFocus = false, 
      this.inputBorder = true});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return
        // Expanded(
        //   child:
        Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        height: 42.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: widget.borderRadius ??
              BorderRadius.all(
                Radius.circular(38.0),
              ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: widget.padding ??
              const EdgeInsets.only(left: 24, right: 16, top: 12, bottom: 4),
          child: TextFormField(
            autofocus: widget.autoFocus,
            validator: widget.validator,
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            textInputAction: TextInputAction.next,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              border: widget.inputBorder? UnderlineInputBorder():InputBorder.none,
              hintText: widget.hintText,
              errorText: widget.errorMsg,
            ),
            inputFormatters: widget.inputFormatters ?? [],
          ),
        ),
      ),
      //),
    );
  }
}

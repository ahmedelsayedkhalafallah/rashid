import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/global.dart';

class MyPhoneField extends StatefulWidget {
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
  const MyPhoneField(
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
      this.onChanged});

  @override
  State<MyPhoneField> createState() => _MyPhoneFieldState();
}

class _MyPhoneFieldState extends State<MyPhoneField> {
  @override
  Widget build(BuildContext context) {
    return
        // Expanded(
        //   child:
        Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: const BorderRadius.all(
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
          padding:
              const EdgeInsets.only(left: 24, right: 16, top: 4, bottom: 4),
          child: Row(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: CountryCodePicker(
              //     enabled: false,
              //     padding: EdgeInsets.all(8.0),
              //     builder: (p0) {
              //       return Container(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //             horizontal: 2,
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               if (p0?.code != null)
              //                 Image.asset(
              //                   p0!.flagUri!,
              //                   package: 'country_code_picker',
              //                   width: 24,
              //                 ),
              //               // decorate others
              //               const Icon(Icons.arrow_drop_down),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //     showDropDownButton: true,
              //     onChanged: (CountryCode countryCode) {
              //       widget.controller.text =
              //           countryCode.dialCode!.replaceRange(0, 2, '');
              //     },
              //     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              //     initialSelection: 'EG',
              //     alignLeft: true,
              //     showFlag: true,

              //     // showCountryOnly: false,
              //   ),
              // ),
              Expanded(
                flex: 4,
                child: TextFormField(
                    textDirection:
                        isArabic() ? TextDirection.ltr : TextDirection.ltr,
                    validator: (value) {
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value!.isEmpty) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value.toString())) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    controller: widget.controller,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    focusNode: widget.focusNode,
                    onTap: widget.onTap,
                    textInputAction: TextInputAction.next,
                    onChanged: widget.onChanged,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                    decoration: InputDecoration(
                      suffixIcon: widget.suffixIcon,
                      prefixIcon: widget.prefixIcon,
                      hintText: widget.hintText,
                      errorText: widget.errorMsg,
                    )),
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}

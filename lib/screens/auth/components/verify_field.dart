import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../components/my_text_field.dart';
import '../../../constants/global.dart';

class VerifyField extends StatefulWidget {
  final String? errorMsg;
  final TextEditingController inputController;
  TextEditingController? nextController;
  final FocusNode focusNode;
  final FocusNode? nextNode;
  final FocusNode? previousNode;
  final bool? autoFocus;
   VerifyField(
      {super.key,
      required this.errorMsg,
      required this.inputController,
      required this.focusNode,
      required this.nextNode, required this.nextController,required this.previousNode, this.autoFocus});

  @override
  State<VerifyField> createState() => _VerifyFieldState();
}

class _VerifyFieldState extends State<VerifyField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width:isArabic()?0: MediaQuery.of(context).size.width * 0.02),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.12,
          child: MyTextField(
            inputBorder: false,
            borderRadius: BorderRadius.circular(12.0),
            autoFocus: widget.autoFocus ?? false,
            padding: EdgeInsets.only(right: isArabic()?18.0:0, left: isArabic()?0: 18.0),
            controller: widget.inputController,
            hintText: "",
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            obscureText: false,
            keyboardType: TextInputType.number,
            errorMsg: widget.errorMsg,
            validator: (val) {
              
            },
            focusNode: widget.focusNode,
            onChanged: (String? newVal) {
              if (newVal?.length == 1) {
               widget.nextNode != null? widget.focusNode.unfocus():{};
               widget.nextNode != null? FocusScope.of(context).requestFocus(widget.nextNode):{};
              //  widget.nextController != null? widget.nextController = TextEditingController(text: ""): {};
              }else{
                widget.previousNode != null? widget.focusNode.unfocus():{};
               widget.previousNode != null? FocusScope.of(context).requestFocus(widget.previousNode):{};
              }
            },
          ),
        ),
        SizedBox(width:isArabic()? MediaQuery.of(context).size.width * 0.02:0,)
      ],
    );
    
  }
}

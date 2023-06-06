import 'package:flutter/material.dart';
import 'package:proiect/presentation/resource/custom_colors.dart';
import 'package:proiect/presentation/resource/custom_font.dart';
import 'package:proiect/presentation/resource/custom_text_style.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController input;
  final String text;
  final TextInputType typeinput;
  final String? Function(String?)? conditionInput;
  //final bool? isObscure;

  const CustomTextField(
      {super.key,
      required this.text,
      required this.typeinput,
      required this.input,
      this.conditionInput});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: widget.conditionInput,
      controller: widget.input,
      keyboardType: widget.typeinput,
      autofocus: false,
      style: CustomTextStyle.interRaisinBlack16w400,
      decoration: InputDecoration(
        hintStyle:
        const TextStyle(fontFamily: CustomFonts.inter,
            fontSize: 16, color: CustomColors.platinum),
        contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        hintText: widget.text,
        filled: true,
        fillColor: Colors.white,
        //errorText: widget.validate ? 'Câmpul trebuie completat': null,        // errorStyle: TextStyle(color: Colors.red),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
                width: 1, color: CustomColors.argent)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                width: 1, color: CustomColors.brigthGrey)),
      ),
    );
  }
}

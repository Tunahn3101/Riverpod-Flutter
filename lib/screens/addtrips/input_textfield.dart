// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    super.key,
    required this.labletext,
    required this.controller,
    required this.validator,
  });

  TextEditingController controller = TextEditingController();
  final String labletext;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: validator,
      controller: controller,
      style: TextStyle(
        fontSize: 14,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      decoration: InputDecoration(
        labelText: labletext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(width: 1, color: Colors.black),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            controller.clear();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: const Icon(Icons.close),
        ),
      ),
    );
  }
}

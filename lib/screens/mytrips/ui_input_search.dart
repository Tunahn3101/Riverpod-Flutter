import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiInputSearch extends StatelessWidget {
  const UiInputSearch({
    super.key,
    required this.onSearch,
    required this.controller,
  });
  final void Function(String) onSearch;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 4),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onSearch,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
                decoration: InputDecoration(
                  hintText: 'Search destination',
                  hintStyle: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 14)),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clear();
                onSearch('');
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }
}

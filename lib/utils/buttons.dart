import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myButton extends StatelessWidget {
  final String name;
  VoidCallback onPressed;
  myButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Text(
        name,
        style: GoogleFonts.poppins(),
      ),
    );
  }
}

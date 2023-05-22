import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
class InfoCardCharComponent {
  static Widget defaultComponent(String icon, String text, String description) {
    return Column(
      children: [
        Row(children: [
          Image.asset(icon, scale: 30),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(text, style: GoogleFonts.poppins(fontSize: 12)),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(description, style: GoogleFonts.poppins(fontSize: 10)),
        )
      ],
    );
  }
}

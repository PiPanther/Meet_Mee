import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class aboutContainer extends StatelessWidget {
  const aboutContainer({
    super.key,
    required this.userProfilemap,
    required this.dataString,
    required this.iconData,
  });
  final String dataString;
  final Map<String, dynamic>? userProfilemap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Colors.white54, // Start color
            Colors.white, // End color
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 5),
          Text(
            userProfilemap?[dataString] ?? "Error Fetching Data...",
            style: GoogleFonts.pacifico(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

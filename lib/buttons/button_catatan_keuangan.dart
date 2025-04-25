import 'package:dompetku_application/modals/modal_catatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCatatanKeuangan extends StatelessWidget {
  const ButtonCatatanKeuangan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Set background to white
          side: BorderSide(
            color: Colors.purple.shade600, // Set border color to purple
            width: 3, // Border width
          ),
          elevation: 4, // Keep shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
        onPressed: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => ModalCatatanScreen(),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/catatan2.svg', // No color modification here
              height: 28,
              width: 28,
            ),
            const SizedBox(width: 5),
            Text(
              "Catatan",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900, // Make the text bolder
                color: Colors.purple.shade600, // Set text color to purple
              ),
            ),
          ],
        ),
      ),
    );
  }
}

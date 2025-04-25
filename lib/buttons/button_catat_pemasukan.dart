import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dompetku_application/modals/modal_pemasukan.dart';

class ButtonCatatPemasukan extends StatelessWidget {
  const ButtonCatatPemasukan({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Set background to white
          side: BorderSide(
            color: Colors.green.shade600, // Set border color to green
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
            builder: (context) => ModalPemasukanScreen(),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/pemasukan2.svg', // No color modification here
              height: 28,
              width: 28,
            ),
            const SizedBox(width: 5),
            Text(
              " Pemasukan",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900, // Make the text bolder
                color: Colors.green.shade600, // Set text color to green
              ),
            ),
          ],
        ),
      ),
    );
  }
}

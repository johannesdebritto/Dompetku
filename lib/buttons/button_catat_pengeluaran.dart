import 'package:dompetku_application/modals/modal_pengeluaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCatatPengeluaran extends StatelessWidget {
  const ButtonCatatPengeluaran({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Set background to white
          side: BorderSide(
            color: Colors.yellow.shade800, // Set border color to green
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
            builder: (context) => ModalPengeluaranScreen(),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/pengeluaran2.svg', // No color modification here
              height: 28,
              width: 28,
            ),
            const SizedBox(width: 5),
            Text(
              " Pengeluaran",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w900, // Make the text bolder
                color: Colors.yellow.shade800, // Set text color to green
              ),
            ),
          ],
        ),
      ),
    );
  }
}

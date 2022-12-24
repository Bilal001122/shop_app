import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/login_screen/login_screen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salla',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.clearData(key: 'token').then(
                (value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                ),
              );
            },
            child: const Text(
              'SIGN OUT',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shared/components/default_form_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LOGIN',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'login now to browse our hot offers ',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DefaultFormField(
              controller: emailController,
              onTap: () {},
              onFieldSubmitted: (value) {},
              isPassword: false,
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              onValidate: (String? value) {
                if (value!.isEmpty) {
                  return 'please enter your email address';
                } else {
                  return '';
                }
              },
              onChanged: (value) {},
              label: const Text(
                'Email Address',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DefaultFormField(
              controller: passwordController,
              onTap: () {},
              onFieldSubmitted: (value) {},
              isPassword: true,
              textInputType: TextInputType.visiblePassword,
              prefixIcon: Icons.lock_outline,
              suffixIcon: Icons.visibility_outlined,
              onValidate: (String? value) {
                if (value!.isEmpty) {
                  return 'password is too short';
                } else {
                  return '';
                }
              },
              onChanged: (value) {},
              label: const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

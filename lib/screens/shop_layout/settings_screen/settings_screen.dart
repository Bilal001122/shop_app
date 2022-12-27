import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/login_screen/login_screen.dart';
import 'package:shop_app/shared/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/components/default_form_field.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (AppCubit.get(context).userModel != null) {
          nameController.text =
              AppCubit.get(context).userModel!.userData!.name!;
          emailController.text =
              AppCubit.get(context).userModel!.userData!.email!;
          phoneController.text =
              AppCubit.get(context).userModel!.userData!.phone!;
        }
      },
      builder: (context, state) {
        return AppCubit.get(context).userModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefaultFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      isPassword: false,
                      onFieldSubmitted: (value) {},
                      onTap: () {},
                      onChanged: (value) {},
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.person,
                      label: Text(
                        'Name',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      isPassword: false,
                      onFieldSubmitted: (value) {},
                      onTap: () {},
                      onChanged: (value) {},
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.email,
                      label: Text(
                        'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      isPassword: false,
                      onFieldSubmitted: (value) {},
                      onTap: () {},
                      onChanged: (value) {},
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        } else {
                          return null;
                        }
                      },
                      prefixIcon: Icons.person,
                      label: Text(
                        'Phone',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          CacheHelper.clearData(key: 'token').then((value) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LoginScreen();
                              },
                            ));
                          });
                        },
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

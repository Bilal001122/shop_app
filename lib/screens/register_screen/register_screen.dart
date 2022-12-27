import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/shop_layout/shop_layout.dart';

import '../../shared/cache_helper/cache_helper.dart';
import '../../shared/components/default_form_field.dart';
import '../../shared/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode phoneFocusNode;

  @override
  Widget build(BuildContext context) {
    passwordFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppRegisterSuccessState) {
          if (state.registerModel!.status) {
            Fluttertoast.showToast(
              msg: state.registerModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
            CacheHelper.saveData(
                    key: 'token', value: state.registerModel!.userData!.token)
                .then((value) {
              token = CacheHelper.getData(
                key: 'token',
              );
              AppCubit.get(context).getUserData();
              AppCubit.get(context).getFavData();
              AppCubit.get(context).getHomeData();
              AppCubit.get(context).getCategoriesData();
              return Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopLayout(),
                  ),
                  (route) => false);
            });
          } else {
            print(state.registerModel!.message);
            Fluttertoast.showToast(
              msg: state.registerModel!.message!,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        'Register now to browse our hot offers ',
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
                        controller: nameController,
                        onTap: () {},
                        onFieldSubmitted: (value) {
                          emailFocusNode.requestFocus();
                        },
                        isPassword: false,
                        textInputType: TextInputType.name,
                        prefixIcon: Icons.person,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        label: const Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        onTap: () {},
                        onFieldSubmitted: (value) {
                          passwordFocusNode.requestFocus();
                        },
                        isPassword: false,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          } else {
                            return null;
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
                      BlocBuilder<AppCubit, AppStates>(
                        buildWhen: (previous, current) {
                          return current is AppChangePasswordVisibilityState2;
                        },
                        builder: (context, state) {
                          return DefaultFormField(
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            onTap: () {},
                            onFieldSubmitted: (value) {
                              phoneFocusNode.requestFocus();
                            },
                            suffixTap: () {
                              AppCubit.get(context).changePasswordVisibility();
                            },
                            isPassword: AppCubit.get(context).isPasswordShown,
                            textInputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: AppCubit.get(context).suffix,
                            onValidate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                            label: const Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultFormField(
                        focusNode: phoneFocusNode,
                        controller: phoneController,
                        onTap: () {},
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        isPassword: false,
                        textInputType: TextInputType.phone,
                        prefixIcon: Icons.phone,
                        onValidate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        label: const Text(
                          'Phone',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: state is! AppRegisterLoadingState
                            ? TextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

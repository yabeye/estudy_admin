import 'package:estudy_admin/constants/controllers.dart';
import 'package:estudy_admin/constants/style.dart';
import 'package:estudy_admin/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/custom_text.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(
                      "assets/icons/logo.svg",
                      color: active,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text(
                    "E-Study",
                    style: GoogleFonts.roboto(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
                      style: GoogleFonts.roboto(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Welcome back to the E-Study admin panel",
                    color: appLightGrey,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: usersController.emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "admin@estudy.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                controller: usersController.passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123456",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         Checkbox(value: true, onChanged: (value) {}),
              //         CustomText(
              //           text: "Remeber Me",
              //         ),
              //       ],
              //     ),
              //     // CustomText(text: "Forgot password?", color: active)
              //     CustomText(text: "", color: active)
              //   ],
              // ),
              SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  if (await usersController.login()) {
                    Get.offAllNamed(rootRoute);
                    return;
                  }
                  toasty(
                    context,
                    "Wrong credentials",
                    bgColor: danger,
                    textColor: white,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: active, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Do not have admin credentials? "),
                // TextSpan(
                //     text: "Request Credentials! ",
                //     style: TextStyle(color: active))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

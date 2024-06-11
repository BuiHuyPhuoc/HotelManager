import 'package:flutter/material.dart';
import 'package:booking_hotel/screens/signin_screen.dart';
import 'package:booking_hotel/screens/signup_screen.dart';
import 'package:booking_hotel/theme/theme.dart';
import 'package:booking_hotel/widgets/custom_scaffold.dart';
import 'package:booking_hotel/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
                    child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'Welcome Back!\n',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text:
                            '\nEnter personal details to your employee account',
                        style: TextStyle(
                          fontSize: 20,
                        ))
                  ]),
                ))),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignUpScreen(),
                      color: Colors.white,
                      textColor: lightColorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

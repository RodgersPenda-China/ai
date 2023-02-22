import 'package:chatgpt/src/pages/home_page.dart';
import 'package:chatgpt/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () async {
      final prefs = await SharedPreferences.getInstance();
      final String? action = prefs.getString('installed');
      if(action != 'yes'){

        setState(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  OnBoarding(),
            ),
          );
        });

      } else {
        final String? login = prefs.getString('login');
        if(login != 'yes'){
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  loginScreen(),
              ),
            );
          });
        } else {
          setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  HomePage(),
              ),
            );
          });
        }
      }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/openai.svg',
          height: 130,
        ),
      ),
    );
  }
}

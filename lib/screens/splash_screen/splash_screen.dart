import 'package:education_app/layout/main_layout.dart';
import 'package:education_app/shared/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  void init(){
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>MainLayout()), (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage("assets/images/logo.png"))
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mid_term/widgets/progress_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 0, 212),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/jack.jpg',
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(height: 40),
          const ProgressBar(),
        ],
      ),
    );
  }
}

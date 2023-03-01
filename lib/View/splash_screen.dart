import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'world_score.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3),
        ()=> Navigator.push(context,
            MaterialPageRoute(builder: (context)=> WorldScore()))
    );
  }

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: _controller,
                child: const Center(
                  child: Image(image: AssetImage('images/virus.png'),),
                ),
                builder: (context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 3.0 * math.pi,
                    child: child,
                  );
                }
            ),
            const SizedBox(
              height: 60,
            ),
            const Text('COVID TRACKER',style: TextStyle(color: Colors.white,fontSize: 22),)

          ],
        ),
      ),
    );
  }
}

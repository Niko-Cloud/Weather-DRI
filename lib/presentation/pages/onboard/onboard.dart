import 'package:flutter/material.dart';
import 'package:niko_driweather/presentation/pages/home/home.dart';
import 'package:niko_driweather/utils/color_palette.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _sunAnimation;
  late final Animation<double> _secondImageAnimation;
  late final Animation<double> _bottomAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _sunAnimation = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _secondImageAnimation = Tween<double>(begin: 300, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _bottomAnimation = Tween<double>(begin: 600, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/Onboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: AnimatedBuilder(
                  animation: _sunAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_sunAnimation.value, 0),
                      child: SizedBox(
                        width: 95,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/img/sun_onboard.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 180.0),
                child: AnimatedBuilder(
                  animation: _secondImageAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_secondImageAnimation.value, 0),
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/img/cloud_onboard.png',
                    fit: BoxFit.contain,
                    width: 360,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 290.0, left: 50, right: 50),
                  child: AnimatedBuilder(
                      animation: _bottomAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bottomAnimation.value),
                          child: child,
                        );
                      },
                      child: Text("Never get caught in the rain again",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 36,
                              color: ColorPalette.textDark,
                              fontWeight: FontWeight.w600)
                      )
                  ),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                  const EdgeInsets.only(bottom: 230.0, left: 50, right: 50),
                  child: AnimatedBuilder(
                      animation: _bottomAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bottomAnimation.value),
                          child: child,
                        );
                      },
                      child: Text("Stay ahead of the weather with our accurate forecasts",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorPalette.textDark,)
                      )
                  ),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                  const EdgeInsets.only(bottom: 140.0, left: 50, right: 50),
                  child: AnimatedBuilder(
                      animation: _bottomAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bottomAnimation.value),
                          child: child,
                        );
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder:(context) => Home()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          overlayColor: Colors.black,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                color: ColorPalette.textDark,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8), //
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorPalette.textDark,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

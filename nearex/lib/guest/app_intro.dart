import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearex/guest/advantage_introduction.dart';
import 'package:nearex/utils/common_widget.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppStartState();
  }
}

class _AppStartState extends State<AppStart> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(gradient: ColorBackground.lightBlueGradient),
        child: Center(
            child: Animate(
          effects: const [FadeEffect(), SlideEffect()],
          delay: const Duration(milliseconds: 500),
          child: Image.asset('images/logo_simple.png'),
          onComplete: (controller) => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AppIntro()))
          },
        )));
  }
}

class AppIntro extends StatefulWidget {
  const AppIntro({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppIntroState();
  }
}

class _AppIntroState extends State<AppIntro> {
  late double _screenWidth;
  @override
  Widget build(BuildContext context) {
    _screenWidth = DimensionValue.getScreenWidth(context);
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(color: ColorBackground.textColor1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/logo_slogan.png'),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 0, horizontal: _screenWidth / 12),
                  child: Text(
                    'Cuối tháng hết tiền? Một bữa no với chi phí cực rẻ? Tại sao không?',
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 175, 175, 175),
                      fontSize: _screenWidth / 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: _screenWidth / 12,
                ),
                InkWell(
                    onTap: _onTap,
                    child: Container(
                      width: DimensionValue.getScreenWidth(context) * 0.5,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(50),
                          color: ColorBackground.backgroundColor1),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: _screenWidth / 36,
                            horizontal: _screenWidth / 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mua Hàng Ngay',
                              style: GoogleFonts.outfit(
                                  color: ColorBackground.blueberry,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: DimensionValue.getScreenWidth(context) *
                                  0.5 *
                                  0.25,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: ColorBackground.blueGradient),
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                color: ColorBackground.backgroundColor1,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                Image.asset('images/banner_buy.png')
              ],
            )));
  }

  void _onTap() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AdvantageIntroduction()));
  }
}

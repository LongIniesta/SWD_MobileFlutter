import 'package:flutter/material.dart';
import 'package:nearex/common/common_widget.dart';

class UnknownName extends StatelessWidget {
  const UnknownName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(gradient: ColorBackground.lightBlueGradient),
        child: Center(child: Image.asset('images/logo_simple.png')));
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
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: ColorBackground.eerieBlack),
        child: Column(
          children: [
            Image.asset('images/logo_slogan.png'),
            const Text(
                'Cuối tháng hết tiền? Một bữa no với chi phí cực rẻ? Tại sao không?'),
            InkWell(
                onTap: () => {},
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50),
                      color: ColorBackground.bubbles),
                  child: Row(
                    children: [
                      const Text(
                        'Mua hàng ngay',
                        style: TextStyle(color: ColorBackground.blueberry),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                            gradient: ColorBackground.blueGradient),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: ColorBackground.bubbles,
                        ),
                      )
                    ],
                  ),
                )),
            Image.asset('images/banner_buy.png')
          ],
        ));
  }
}

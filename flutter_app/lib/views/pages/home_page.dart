import 'package:flutter/material.dart';
import 'package:flutter_app/views/data/constants.dart';
import 'package:flutter_app/views/widgets/hero_widget.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            HeroWidget(title: "Home"),
            Lottie.asset('assets/lotties/home.json'),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Basic Layout", style: KTextStyle.titleTealText),
                      Text(
                        "The Description of this",
                        style: KTextStyle.descriptionText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

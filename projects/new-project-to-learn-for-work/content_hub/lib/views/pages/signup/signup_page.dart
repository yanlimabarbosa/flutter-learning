import 'package:content_hub/ui/base_card_widget.dart';
import 'package:content_hub/ui/eyebrow_text_widget.dart';
import 'package:content_hub/ui/hero_description_widget.dart';
import 'package:content_hub/ui/hero_title_widget.dart';
import 'package:content_hub/views/pages/signup/widgets/signup_form_card_widget.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                EyebrowText(text: "START LEARNING"),
                SizedBox(height: 10),
                HeroTitle(text: "Create your content library."),
                SizedBox(height: 10),
                HeroDescription(
                  description:
                      "Save courses, track progress, and keep your study path available across devices.",
                ),
                SizedBox(height: 20),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: BaseCard(
                          title: "Personal Path",
                          description:
                              "Build a library around the skills you are learning.",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BaseCard(
                          title: "Sync later",
                          description:
                              "Prepare for auth, offline data, and real API flows.",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                SignupFormCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

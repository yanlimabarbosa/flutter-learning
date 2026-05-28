import 'package:content_hub/shared/widgets/base_card_widget.dart';
import 'package:content_hub/shared/widgets/eyebrow_text_widget.dart';
import 'package:content_hub/shared/widgets/hero_description_widget.dart';
import 'package:content_hub/shared/widgets/hero_title_widget.dart';
import 'package:content_hub/views/pages/login/widgets/login_form_card_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     BrandMark(
                //       text: "CH",
                //       firstColorGradient: colors.primary,
                //       secondColorGradient: colors.primaryContainer,
                //     ),
                //     StatusPill(
                //       text: "Member access",
                //       textColor: colors.primary,
                //     ),
                //   ],
                // ),
                SizedBox(height: 40),
                EyebrowText(text: "MODERN EDITORIAL"),
                SizedBox(height: 10),
                HeroTitle(text: "Learn, save, and continue anywhere."),
                SizedBox(height: 10),
                HeroDescription(
                  description:
                      "Access curated courses, keep favorites close, and download lessons for offline study.",
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: BaseCard(
                        title: "Mobile Patterns",
                        description:
                            "Navigation, forms, state and real app flows.",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BaseCard(
                        title: "Offline ready",
                        description:
                            "Save lessons locally and sync progress later.",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                LoginFormCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

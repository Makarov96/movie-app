import 'package:flutter/material.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class CardModel {
  const CardModel({
    required this.url,
    required this.primaryTitle,
    required this.title,
    required this.subTitle,
    required this.title2,
    required this.subTitle2,
    required this.title3,
    required this.subTitle3,
  });
  final String url;
  final String primaryTitle;
  final String title;
  final String subTitle;
  final String title2;
  final String subTitle2;
  final String title3;
  final String subTitle3;
}

class KueskiHorizontalCard extends StatelessWidget {
  const KueskiHorizontalCard({
    super.key,
    required this.model,
    this.onTap,
  });
  final CardModel model;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    var sizeof = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: sizeof.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                KueskiNetworkCacheImage(
                  width: 120,
                  height: double.infinity,
                  imageUrl: model.url,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        model.primaryTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ComboText(
                        text: model.title,
                        value: model.subTitle,
                      ),
                      ComboText(
                        text: model.title2,
                        value: model.subTitle2,
                      ),
                      ComboText(
                        text: model.title3,
                        value: model.subTitle3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

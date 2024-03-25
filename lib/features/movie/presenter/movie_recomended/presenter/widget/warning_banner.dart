import 'package:flutter/material.dart';
import 'package:kueski_challenge/core/router/routes.dart';
import 'package:kueski_challenge/i18n/translations.g.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(20),
          topStart: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.texts.recommended.warningTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 25,
          ),
          Wrap(
            spacing: 30,
            children: [
              ElevatedButton(
                onPressed: () =>
                    context.pushReplacementNamed(const Routes.movie().name),
                child: Text(context.texts.recommended.goToHome),
              ),
              ElevatedButton(
                onPressed: () =>
                    context.pushReplacementNamed(const Routes.movie().name),
                child: Text(context.texts.recommended.keepWatching),
              )
            ],
          )
        ],
      ),
    );
  }
}

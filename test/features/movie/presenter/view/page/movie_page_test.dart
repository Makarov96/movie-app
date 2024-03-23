import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:kueski_challenge/features/movie/_module/keys/movie_keys.dart';

import 'package:kueski_challenge/features/movie/presenter/movie/view/page/movie_page.dart';
import 'package:mobile_dependencies/mobile_dependencies.dart';

import '../../../../../common/helper/widget_under.dart';

void main() {
  late MoviesPage moviesPage;

  setUp(
    () {
      moviesPage = const MoviesPage(
        key: Moviekeys.moviesPageKey,
      );
    },
  );
  group(
    'success case -  custom grid layout',
    () {
      testWidgets(
        'should be return a custom grid layout',
        (tester) async {
          await tester.pumpWidget(
            WidgetUnderTest.appTest(moviesPage),
          );

          await tester.pump();

          final itemCount =
              tester.widgetList<KueskieCard>(find.byType(KueskieCard)).length;

          await tester.tap(find.byIcon(Icons.star).first);
          await tester.tap(find.byType(GestureDetector).first);
          await tester.tap(find.byType(GestureDetector).last);
          expect(itemCount, mockData.length);
          expect(
            find.byKey(Moviekeys.moviesPageKey),
            findsOneWidget,
          );
          expect(
            find.text('Mock Movie Title'),
            findsOneWidget,
          );
          expect(
            find.byKey(
              Moviekeys.moviesPageKey,
            ),
            findsOneWidget,
          );
        },
      );
      testWidgets(
        'should be return a custom KueskieSliverGridToList',
        (tester) async {
          final sliverGridToList = KueskieSliverGridToList(
            key: Moviekeys.sliverGridToList,
            trigger: () {},
            toggle: false,
            data: const [],
            itemBuilder: (context, index, value) => Container(),
            contorller: ScrollController(),
          );
          await tester.pumpWidget(
            WidgetUnderTest.appTest(sliverGridToList),
          );

          await tester.pump();

          expect(
            find.byKey(Moviekeys.sliverGridToList),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'should be return a custom KueskiCard',
        (tester) async {
          final kueskiCard = KueskieCard(
            key: Moviekeys.kueskiCard,
            imagePath: '',
            title: 'hello world',
            popularity: 2,
            voteCount: 2,
            voteAverage: 2,
            movieId: Moviekeys.kueskiCard.toString(),
          );
          await tester.pumpWidget(
            WidgetUnderTest.appTest(kueskiCard),
          );

          await tester.pump();

          expect(
            find.text('hello world'),
            findsOneWidget,
          );
        },
      );
    },
  );
}

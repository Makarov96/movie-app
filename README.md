# Kueski Challenge

![coverage][coverage_badge]
![license][license_badge]

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart --dart-define-from-file=env/dev.json

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart --dart-define-from-file=env/stg.json

# Production
$ flutter run --flavor production --target lib/main_production.dart --dart-define-from-file=env/prod.json
```

#### WARNING 📌

You must be create the following directory:

- env: lib level, then your directory structure looks like it:

  - lib
  - env
  - ios
  - android
  - etc

- inside to env you must be create the following files:
  - dev.json
  - stg.json
  - prod.json

The above files must be content the following variables and values:

```json
{
  "MOVIE_API_KEY_READ_ACCESS": "YOUR_MOVIE_API_KEY_READ_ACCESS",
  "BASE_URL": "https://api.themoviedb.org"
}
```

Be careful with the above content; you don't have to share your MOVIE_API_KEY_READ_ACCESS with anyone. Even though you have to ignore the env directory into gitignore.

### Recommendation 👁️

If you don't do the before stuffs, the mobile app won't be able to compile.

_\*Kueski Challenge works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ ./runTest.sh

```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

Alternatively, run `flutter run` and code generation will take place automatically.

## Artifacts 📦

This project has apk and ipa in the summary of the last github action build, in the following link you can checked:
[action](https://github.com/Makarov96/kueski-challenge/actions/runs/8405879173)

### also

You can download this app using Diawi

- IOS 📱: https://i.diawi.com/cgEhbi
- Android 🤖: https://i.diawi.com/SHibB9
- How does it work? ⛏️: https://youtu.be/dTDhCVxptLk

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT

## Q&A 🗒️

- Q: How long did you spend on this?

  A: 4 days

- Q: Did you complete your implementation?

  A: No really, I wasn't be able to complete the design system, I would have liked to develope a responsive design and integrate a local data base for add on it my favorite movie.

- Q: What would you have added if you had more time?

  A: A responsive design and, continuous delivery, a database local such as: isar, hive or others.

- Q: What was the most difficult part of the app?

  A: Maybe it was when I was implementing the continuous integration, because setting the provisioning profile and certificate is always a challenge.

- Q: What was your favorite part of the app?

  A: When I had to create a custom sliver to change from list to grid, it was very fun and challenging.

- Q: Is there anything else you’d like to add?

  A: No, really, just thanks for the opportunity. I appreciate this kind of challenge.

rm -r coverage
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/*.g.dart' -o coverage/lcov.info
genhtml -o coverage coverage/lcov.info
open coverage/index.html

## if you system it's windot change [open] to [start]
## run this file using: sh runTst.sh
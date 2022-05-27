import 'dart:math';

import 'testing.dart' as testee;
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

var log = [];
void main() {
  test('override print', overridePrint(() {
    testee.main();
    expect(log, ['10']);
  }));
}

void Function() overridePrint(void testFn()) => () {
      // ignore: unnecessary_new
      var spec = new ZoneSpecification(print: (_, __, ___, String msg) {
        // Add to log instead of printing to stdout
        log.add(msg);
      });
      return Zone.current.fork(specification: spec).run<void>(testFn);
    };


import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  test('calculates 15 percent tip correctly', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75.0);
    expect(result.total, 575.0);
  });

  test('calculates 10 percent tip correctly', () {
    final result = computeTip(500, 10);

    expect(result.tip, 50.0);
    expect(result.total, 550.0);
  });

  test('calculates 20 percent tip correctly', () {
    final result = computeTip(500, 20);

    expect(result.tip, 100.0);
    expect(result.total, 600.0);
  });
}

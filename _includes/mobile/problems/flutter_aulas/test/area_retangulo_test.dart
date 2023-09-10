import 'package:flutter_aulas/area_retangulo.dart';
import 'package:test/test.dart';

void main() {
  // unit test dizAlo
  test('retangulo', () {
    expect(area_retangulo(1.5, 2), 3.0);
    expect(area_retangulo(10, 2), 20.0);
    expect(area_retangulo(0, 2), 0.0);
    expect(area_retangulo(1, 0), 0.0);
    expect(area_retangulo(0, 0), 0.0);
    expect(area_retangulo(1, 1), 1.0);
    expect(area_retangulo(1.5, 3.0), 4.5);
  });
}

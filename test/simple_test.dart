import 'package:test/test.dart';
import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';
main () {
  var selector;
  setUp(() {
    var dims = [
      'dim1',
      'dim2'
    ];
     selector = new DimensionSelector();
     selector.init(dims);
  });
  test('Initialisation', () {
    expect(selector.availableDims, isNotEmpty);
    expect(selector.availableDims.length, 4);
  });
}
import 'package:test/test.dart';
import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';
main () {

  var selector;

  setUp(() {
    selector = new DimensionSelector();
     selector.init(col: ["1","2", "3"], str: ["1","2"]);
  });

  test('Initialisation', () {
    expect(selector.availableDims, isNotEmpty);
    expect(selector.availableDims.length, 55);
  });

  test('sort', () {
    selector.sort("2","1");
    expect(selector.selectedStr, ["2","1"]);
    expect(selector.selectedCol, ["2","1", "3"]);
  });

  test('moveFromTo', () {
    selector.moveFromTo('col', 'str', '3');
    expect(selector.selectedCol, ["1","2"]);
    expect(selector.selectedStr, ["1","2", "3"]);
  });

}
import 'package:test/test.dart';
import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';
main () {
  var selector;
  setUp(() {
     selector = new DimensionSelector();
     selector.init();
  });
  test('Initialisation', () {
    expect(selector.availableDims, isNotEmpty);
    expect(selector.availableDims.length, 55);

  });
  test('rmDuplicate', () {
    selector.selectedCol = ["1","2","3","1"];
    selector.selectedStr = ["1","2","3","1"];
    selector.rmDuplicate();
    expect(selector.selectedCol.length, 3);
    expect(selector.selectedCol.length, 3);
  });

  test('rmDuplicateFromAnotherList', () {
    selector.selectedCol = ["1","2","3","1"];
    selector.selectedStr = ["1"];
    selector.rmDuplicateFromAnotherList('col');
    expect(selector.selectedStr.length, 0);
  });

  test('dragSelectedSort', () {
    selector.selectedCol = ["1","2"];
    selector.selectedStr = ["1","2"];
    selector.dragSelectedSort("2","1");
    expect(selector.selectedCol, ["2","1"]);
    expect(selector.selectedCol, ["2","1"]);
  });
  
}
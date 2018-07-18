import 'package:test/test.dart';
import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';

main() {
  var selector;

  setUp(() {
    selector = new DimensionSelector()..init();
    selector.moveTo('str', 'Дата');
    selector.moveTo('str', 'Неделя');
    selector.moveTo('col', 'Номенклатура');
    selector.moveTo('col', 'Акция');
  });

  test('Initialisation', () {
    expect(selector.availableDims, isNotEmpty);
    expect(selector.availableDims.length, 55);
    expect(selector.selectedStr.length, 2);
    expect(selector.selectedCol.length, 2);
  });

  test('Field availability check', () {
    try {
      selector.moveTo('col', 'Акция1');
    } on AvailException {
      print('Error: field does not exist in the available fields - col');
    }
    try {
      selector.moveTo('str', 'Акция1');
    } on AvailException {
      print('Error: field does not exist in the available fields - str');
    }
  });

  test('sort', () {
    selector.sort("Дата", "Неделя");
    selector.sort("Акция", "Номенклатура");
    expect(selector.selectedStr, ["Дата", "Неделя"]);
    expect(selector.selectedCol, ["Акция", "Номенклатура"]);
  });

  test('moveTo', () {
    selector.moveTo('str', 'Номенклатура');
    expect(selector.selectedCol, ["Акция"]);
    expect(selector.selectedStr, ["Дата", "Неделя", "Номенклатура"]);
  });
}

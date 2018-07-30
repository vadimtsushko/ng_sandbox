import 'package:test/test.dart';
import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';
import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';



main() {
  var selector, filterSelector;

  setUp(() {
    selector = new DimensionSelector()..init();
    selector.moveTo('str', 'Дата');
    selector.moveTo('str', 'Неделя');
    selector.moveTo('col', 'Номенклатура');
    selector.moveTo('col', 'Акция');

    filterSelector = new FilterSelector()..init();
  });

  test('Initialisation', () {
    expect(selector.availableDims, isNotEmpty);
    expect(selector.availableDims.length, 55);
    expect(selector.selectedStr.length, 2);
    expect(selector.selectedCol.length, 2);

    expect(filterSelector.headers.length, 4);
    expect(filterSelector.dataIn.length, 4);
    expect(filterSelector.dataOut.length, 2);
    expect(filterSelector.operators.length, 5);
    expect(filterSelector.filter.length, 1);
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

  test('filterOut', () {
    filterSelector.filter.add([['Количество продано, шт', '==', 3]]);
    expect(filterSelector.dataOut, [[3, 2, 3, 4], [4, 1, 4, 10]]);
    filterSelector.reset();
  });

  test('reset', () {
    filterSelector.reset();
    expect(filterSelector.filter.length, 0);
  });

  // TODO: Как удалить?
  test('rmOneFilter', () {
    // [Количество продано, шт, >=, 3]
    List list = ["Количество продано, шт", ">=", 3];
//    List list =[["Количество продано, шт", ">=", 3]];
    filterSelector.rmOneFilter(list);
//    expect(filterSelector.filter, 0);
  });

  // TODO: Как вызвать add?

}

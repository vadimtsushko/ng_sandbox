import 'package:test/test.dart';
import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';
import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';
import 'package:model/model.dart';

main() {
  DimensionSelector selector;
  FilterSelector filterSelector;
  setUp(() {
    selector = new DimensionSelector()..init();
    selector.moveTo('str', 'Дата');
    selector.moveTo('str', 'Неделя');
    selector.moveTo('col', 'Номенклатура');
    selector.moveTo('col', 'Акция');

    var measures = testMeasures
        .map((map) => fromJson<IvMasterExpression>(IvMasterExpression, map))
        .toList();
    var dimensions = testDimensions
        .map((map) => fromJson<IvMasterDimension>(IvMasterDimension, map))
        .toList();
    filterSelector = new FilterSelector()..init(measures, dimensions);
  });

  test('Initialisation', () {
    expect(selector.availableDims, isNotEmpty);
    expect(selector.availableDims.length, 55);
    expect(selector.selectedStr.length, 2);
    expect(selector.selectedCol.length, 2);
//    expect(filterSelector.dataOut.length, 3);
    expect(filterSelector.operators.length, 5);
//    expect(filterSelector.filter.length, 2);
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


  test('filter reset', () {
    filterSelector.reset();
    expect(filterSelector.filter.length, 0);
  });

//  test('filter rm', () {
//    filterSelector.rm("Количество продано, шт", ">=", 3);
//    expect(filterSelector.filter.length, 2);
//  });
//
  test('filter add', () {
    filterSelector.reset();
    filterSelector.measure = 'КоличествоПродано';
    filterSelector.operator = '>=';
    filterSelector.value = 3;
    filterSelector.add();
    expect(filterSelector.filter.length, 1);
  });

//  test('filter NonExistentArgument', () {
//    try {
//      filterSelector.canAdd(0,'!!',0);
//    } on NonExistentOperator {
//      print('Error: NonExistentOperator');
//    }
//  });

}

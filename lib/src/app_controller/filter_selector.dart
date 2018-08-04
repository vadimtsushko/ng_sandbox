import 'package:model/model.dart';
import 'package:tuple/tuple.dart';
import 'dart:async';

part 'filter_test_data.dart';

class NonExistentOperator implements Exception {
  final String msg;

  const NonExistentOperator([this.msg]);

  @override
  String toString() => msg ?? 'NonExistentOperator';
}

class FilterEvent {
  ActionType type;
  List params;

  FilterEvent(this.type, this.params);
}

class FilterData {
  final String measure;
//  final String dimensions;
  final String operator;
  final num value;

  @override
  String toString() {
    return 'FilterData{measure: $measure, operator: $operator, value: $value}';
  }

  const FilterData(this.measure, this.operator, this.value);

}
enum ActionType { add, remove, reset, apply }

class FilterSelector {
  final applyStreamController =
      StreamController<Tuple2<String, List<FilterData>>>();
  String _operator;

  String get operator => _operator;

  set operator(String value) {
    _operator = value;
    setBtnStatus();
  }

  String _measure;

  String get measure => _measure;

  set measure(String value) {
    _measure = value;
    setBtnStatus();
  }

  String _dimension;

  String get dimension => _dimension;

  set dimension(String value) {
    _dimension = value;
    setBtnStatus();
  }

  num _value;

  num get value => _value;

  set value(num value) {
    _value = value;
    setBtnStatus();
  }

  bool canAdd = false;
  List<IvMasterExpression> measures;
  List<IvMasterDimension> dimensions;

  List<String> headers;
  List<List<int>> dataOut;
  List<FilterData> filter = [];
  List<String> operators = ['<', '>', '<=', '>=', '=='];

  num get filterLength => filter.length;

  bool btnStatus = false;

  init(List<IvMasterExpression> _measures, List<IvMasterDimension> _dimensions) {
    measures = _measures;
    dimensions = _dimensions;
  }

  apply() {
    applyStreamController.add(Tuple2(dimension, filter));
  }

  close() {
    applyStreamController.close();
  }

  void setBtnStatus() {
    btnStatus = !checkCanAdd();
  }

  bool checkCanAdd() {
    bool res = true;

    if (measure == '' || operator == '' || dimension == '' || value == null) {
      res = false;
    } else {
      for (int i = 0; i < filter.length; i++) {
        if (filter[i].measure == measure && filter[i].operator == operator) {
          res = false;
        }
      }
    }
    return res;
  }

  bool isCanAdd(num valData, String operator, int filterData) {
    var res = false;
    if (operator == '<') {
      res = valData < filterData;
    } else if (operator == '>') {
      res = valData > filterData;
    } else if (operator == '<=') {
      res = valData <= filterData;
    } else if (operator == '>=') {
      res = valData >= filterData;
    } else if (operator == '==') {
      res = (valData == filterData);
    } else {
      throw NonExistentOperator();
    }
    return res;
  }

  void rm(String m, String o, num v) {
    print('${m} - ${o} ');
    for (int i = 0; i < filter.length; i++) {
      if (m == filter[i].measure &&
          o == filter[i].operator &&
          v == filter[i].value) {
        filter.removeAt(i);
      }
    }
    setBtnStatus();
  }

  void reset() {
    dimension = dimensions.first.id;
    operator = '';
    measure = '';
    value = null;
    filter = [];
    setBtnStatus();
  }

  void add() {
    filter.add(FilterData(measure, operator, value));
    setBtnStatus();
  }
}

const List<String> testHeaders = [
  'Сумма продаж тыс.руб',
  'Наценка, тыс. руб',
  'Остатки, тыс руб',
  'Количество продано, шт'
];
const List<List<int>> testData = [
  [1, 4, 1, 0],
  [2, 3, 2, 1],
  [3, 2, 3, 4],
  [4, 1, 4, 10]
];


const testFilter = [
//  DataFilter('sdf', '>=', 5),
//  DataFilter('dfgdfg', '<=', 3)
];

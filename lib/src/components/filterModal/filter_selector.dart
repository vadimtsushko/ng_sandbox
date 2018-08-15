import 'package:model/model.dart';
import 'dart:async';

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

enum ActionType { add, remove, reset, apply }

class FilterSelector {
  final applyStreamController = new StreamController<MeasureFilterEvent>();

  bool btnCanApplyDisabled = true;

  double minModalVal = 0.0;
  double maxModalVal = 0.0;

  String _maxOperator;

  String get maxOperator => _maxOperator;

  set maxOperator(String value) {
    _maxOperator = value;
    setBtnStatus();
  }

  String _minOperator;

  String get minOperator => _minOperator;

  set minOperator(String value) {
    _minOperator = value;
    setBtnStatus();
  }

  String _measure;

  String get measure => _measure;

  set measure(String value) {
    _measure = value;
    setMinAndMaxVal(value);
  }

  String _dimension;

  String get dimension => _dimension;

  set dimension(String value) {
    _dimension = value;
    setBtnStatus();
  }

  num _maxValue;

  num get maxValue => _maxValue;

  set maxValue(num value) {
    _maxValue = value;
    setBtnStatus();
  }

  num _minValue;

  num get minValue => _minValue;

  set minValue(num value) {
    _minValue = value;
    setBtnStatus();
  }

  bool canAdd = false;

  List<MeasureForFilter> measures;

  List<IvMasterDimension> dimensions;

  List<String> headers;
  List<List<int>> dataOut;
  List<MeasureFilterItem> filter = [];
  List<String> operators = ['<', '>', '<=', '>=', '=='];

  List<String> operatorsMax = ['<=', '<'];
  List<String> operatorsMin = ['>=', '>'];


  num get filterLength => filter.length;

  bool btnStatus = false;

  init(List<MeasureForFilter> _measures, List<IvMasterDimension> _dimensions) {
    measures = _measures;
    dimensions = _dimensions;
  }

  apply() {
    print(111);
    add();
    applyStreamController.add(new MeasureFilterEvent((b) => b
      ..dimension = dimension
      ..filterItems.addAll(filter)));
  }

  close() {
    applyStreamController.close();
  }

  void setBtnStatus() {
    bool status = true;
    if (minValue != null &&
        minValue >= minModalVal &&
        minValue <= maxModalVal) {
      if (minOperator != null && minOperator != '')
        status = true;
      else
        status = false;
    } else
      status = false;

    if (maxValue != null &&
        maxValue >= minModalVal &&
        maxValue <= maxModalVal) {
      if (maxOperator != null && maxOperator != '')
        status = true;
      else
        status = false;
    } else if (maxValue != null) {
      status = false;
    }

    btnCanApplyDisabled = !status;
  }

  void setMinAndMaxVal(String value) {
    measures.forEach((el) {
      if (el.measure == value) {
        this.minModalVal = el.minValue;
        this.maxModalVal = el.maxValue;
      }
    });
  }

  bool checkCanAdd() {
    bool res = true;

    if (measure == '' ||
        maxOperator == '' ||
        minOperator == '' ||
        dimension == '' ||
        minValue == null) {
      res = false;
    } else {
      for (int i = 0; i < filter.length; i++) {
        if (filter[i].measure == measure && filter[i].minOperator == minValue) {
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
      throw new NonExistentOperator();
    }
    return res;
  }

  void rm(String m, String o, num v) {
    print('${m} - ${o} ');
    for (int i = 0; i < filter.length; i++) {
      if (m == filter[i].measure &&
          o == filter[i].minOperator &&
          v == filter[i].minValue) {
        filter.removeAt(i);
      }
    }
    setBtnStatus();
  }

  void reset() {
    dimension = dimensions.first.id;
    maxOperator = '';
    minOperator = '';
    measure = '';
    minValue = null;
    filter = [];
    setBtnStatus();
  }

  void add() {
    var selectedMeasure = measures.firstWhere((el) => el.measure == measure);

    filter.add(new MeasureFilterItem((b) => b
      ..measure = measure
      ..measureTitle = selectedMeasure.measureTitle
      ..maxOperator = maxOperator
      ..minOperator = minOperator
      ..minValue = minValue
      ..maxValue = maxValue
      ..maxOperator = null
      ..minOperator = null
      ..maxValue = null));
    setBtnStatus();
  }

  getDataFromModal(){
    print('XXXXXXXXXXXXXXXXXXXXXXX');
  }
}

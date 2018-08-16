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
  }

  String _minOperator;

  String get minOperator => _minOperator;

  set minOperator(String value) {
    _minOperator = value;
  }

  String _measure;

  String get measure => _measure;

  set measure(String value) {
    _measure = value;
  }

  String _dimension;

  String get dimension => _dimension;

  set dimension(String value) {
    _dimension = value;
  }

  num _maxValue;

  num get maxValue => _maxValue;

  set maxValue(num value) {
    _maxValue = value;
  }

  num _minValue;

  num get minValue => _minValue;

  set minValue(num value) {
    _minValue = value;
  }

  bool canAdd = false;

  List<MeasureForFilter> measures;

  List<IvMasterDimension> dimensions;
  List<MeasureFilterItem> filter = [];

  List<String> operatorsMax = ['<=', '<'];
  List<String> operatorsMin = ['>=', '>'];

  var updateItems = <String, MeasureFilterItem>{};

  bool btnStatus = false;

  init(List<MeasureForFilter> _measures, List<IvMasterDimension> _dimensions) {
    measures = _measures;
    dimensions = _dimensions;
  }

  apply() {
    updateItems.forEach((i, el){
//    applyStreamController.add(new MeasureFilterEvent((b) => b
//      ..dimension = dimension
//      ..filterItems.addAll(filter)));
    });
  }

  close() {
    applyStreamController.close();
  }


  void reset() {
     updateItems.clear();
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
  }

  updateFilterItem(MeasureFilterItem item){
    if(item != null){
      if (item.minValue != null || item.maxValue != null)
        updateItems[item.measureTitle] = item;
      else
        updateItems.remove(item.measureTitle);
      if (updateItems.length > 0)
        btnCanApplyDisabled = false;
      else
        btnCanApplyDisabled = true;
    } else
      btnCanApplyDisabled = true;
  }

}

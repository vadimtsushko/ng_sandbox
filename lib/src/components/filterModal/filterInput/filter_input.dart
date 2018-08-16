import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:ng_sandbox/src/components/filterModal/filter_selector.dart';
import 'package:model/model.dart';
import '../filter_modal.dart';
import '../filter_selector.dart';

@Component(
  selector: 'filter-input',
  templateUrl: 'filter-input.html',
  styleUrls: ['filter-input.css'],
  directives: [
    coreDirectives,
    routerDirectives,
    formDirectives,
    FilterModalComponent
  ],
)

class FilterInputComponent {

  double _maxValue;

  set maxValue(double value) {
    _maxValue = value;
    updateFilterItem();
  }

  get maxValue => _maxValue;

  double _minValue;

  set minValue(double value) {
      _minValue = value;
      updateFilterItem();
  }

  double get minValue => _minValue;


  String _operatorsMin;

  set operatorsMin(String value) {
    _operatorsMin = value;
    updateFilterItem();
  }

  String get operatorsMin => _operatorsMin;

  String _operatorsMax;

  set operatorsMax(String value) {
    _operatorsMax = value;
    updateFilterItem();
  }

  String get operatorsMax => _operatorsMax;

  FilterSelector _selector;

  @Input()
  set selector(FilterSelector value) {
    _selector = value;
  }

  FilterSelector get selector => _selector;

  MeasureForFilter _measure;

  @Input()
  set measure(MeasureForFilter value) {
    _measure = value;
  }

  MeasureForFilter get measure => _measure;

  updateFilterItem() {
    selector.updateFilterItem(new MeasureFilterItem((b) => b
      ..measure = this.measure.measure
      ..measureTitle = measure.measureTitle
      ..maxOperator = operatorsMax.toString()
      ..minOperator = operatorsMin.toString()
      ..minValue = minValue
      ..maxValue = maxValue
    ));
  }
}

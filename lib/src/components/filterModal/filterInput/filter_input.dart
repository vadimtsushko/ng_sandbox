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

  double _minValue;
  String minValueStatus;
  set minValue(num value) {
      _minValue = value;
      minValueStatus = selector.inputValidator(measure.minValue, measure.maxValue, value);
      updateFilterItem();
  }

  double get minValue => _minValue;

  double _maxValue;
  String maxValueStatus;
  set maxValue(double value) {
    _maxValue = value;
    maxValueStatus = selector.inputValidator(measure.minValue, measure.maxValue, value);
    updateFilterItem();
  }

  double get maxValue => _maxValue;

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
    String _minValueStatus = minValueStatus == null ? '' : minValueStatus;
    String _maxValueStatus = maxValueStatus == null ? '' : maxValueStatus;
    bool isErr = (_minValueStatus + _maxValueStatus).contains('red');

    selector.updateFilterItem(new MeasureFilterItem((b) => b
      ..measure = this.measure.measure
      ..measureTitle = measure.measureTitle
      ..maxOperator = operatorsMax
      ..minOperator = operatorsMin
      ..minValue = minValue
      ..maxValue = maxValue
    ), isErr: isErr);
  }
}

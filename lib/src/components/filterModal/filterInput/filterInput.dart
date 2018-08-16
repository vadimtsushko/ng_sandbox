import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';


import 'package:ng_sandbox/src/components/filterModal/filter_selector.dart';

import 'package:model/model.dart';

import '../filterModal.dart';
import '../filter_selector.dart';
import 'package:ng_sandbox/src/app_controller/event_bus.dart';

@Component(
  selector: 'my-filterInput',
  templateUrl: 'filterInput.html',
  styleUrls: ['filterInput.css'],
  directives: [coreDirectives, routerDirectives, formDirectives, FilterModalComponent],
)

class FilterInput {

  double maxValue;
  double minValue;
  String operatorsMin;
  String operatorsMax;

  FilterSelector selectorLoc;
  @Input()
  set selector(FilterSelector value) {
    selectorLoc = value;
  }

  MeasureForFilter measureLoc;
  @Input()
  set measure(MeasureForFilter value) {
    measureLoc = value;
  }

  getDataFromModal(){
    print('XXXXXXXXXXXXXXXXXXXXXXX');
  }
}



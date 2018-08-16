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
//  set measure(MeasureForFilter value) {
//    measureLoc = value;
//  }

  double minValue;
  String operatorsMin;
  String operatorsMax;

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

  getDataFromModal(){
    print('XXXXXXXXXXXXXXXXXXXXXXX');
  }
}



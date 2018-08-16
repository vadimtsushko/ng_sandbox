import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

import '../filterModal.dart';

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

  var selectorLoc;
  @Input()
  set selector(value) {
    selectorLoc = value;
  }

  var measureLoc;
  @Input()
  set measure(value) {
    measureLoc = value;
  }

  getDataFromModal(){
    print('XXXXXXXXXXXXXXXXXXXXXXX');
  }
}



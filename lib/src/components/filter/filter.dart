import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'dart:html';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';


@Component(
  selector: 'my-filter',
  templateUrl: 'filter.html',
  styleUrls: ['filter.css'],
  directives: [coreDirectives, routerDirectives],
)

class FilterComponent implements OnInit, OnChanges {

  Future<void> ngOnInit() async {}

//TODO: Почему не отрабатывает?
  Future<void> ngOnChanges(Map<String, SimpleChange> changes) async {
    print('ngOnChanges');
  }

  FilterSelector FS = new FilterSelector()..init();

  String getColumnText() {
    var column = (querySelector('#column') as SelectElement);
    return column.value;
  }

  String getOperatorsText() {
    var operators = (querySelector('#operators') as SelectElement);
    return operators.value;
  }

  String getValueText() {
    var value = (querySelector('#value') as InputElement);
    return value.value;
  }
//TODO:  как вызвать в FilterSelector для тестов?
  void add() {
    var columnText = getColumnText();
    var operatorsText = getOperatorsText();
    var valueText = getValueText();
    if (valueText.length > 0) {
      FS.filter.add([columnText, operatorsText, int.parse(valueText)]);
      FS.filterOut();
    }
  }
}

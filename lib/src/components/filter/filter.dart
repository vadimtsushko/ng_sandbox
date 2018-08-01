import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'dart:async';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';
import 'package:angular_tour_of_heroes/src/components/filterModal/filterModal.dart';


@Component(
  selector: 'my-filter',
  templateUrl: 'filter.html',
  styleUrls: ['filter.css'],
  directives: [coreDirectives, routerDirectives, formDirectives, FilterModalComponent],
)

class FilterComponent implements OnInit, OnChanges {

  FilterSelector FS = new FilterSelector()..init();

  reset(){
    FS.reset();
  }

  String rmType;
  String rmOp;
  int rmVal;
  rm(){
    FS.rm(rmType, rmOp, rmVal);
  }

  String columnText;
  String operatorsText;
  int valueText;
  add(){
    FS.add(columnText, operatorsText, valueText);
  }

  Future<void> ngOnInit() async {
    columnText  = FS.headers[0] ?? '';
    operatorsText = FS.operators[0] ?? '';
  }

//TODO: Почему не отрабатывает?
  Future<void> ngOnChanges(Map<String, SimpleChange> changes) async {
    print('ngOnChanges');
  }

}

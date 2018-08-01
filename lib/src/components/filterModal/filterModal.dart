import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'dart:async';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';
import 'package:angular_tour_of_heroes/src/components/filter/filter.dart';


@Component(
  selector: 'my-filterModal',
  templateUrl: 'filterModal.html',
  styleUrls: ['filterModal.css'],
  directives: [coreDirectives, routerDirectives, formDirectives,  FilterComponent],
)

class FilterModalComponent extends FilterComponent {

  final _innerListControllerReset = StreamController<int>();
  @Output()
  Stream<int> get reset_e => _innerListControllerReset.stream;
  void resetFMC(){
    _innerListControllerReset.add(1);
    FS.reset();
  }

  final _innerListControllerRmVal = StreamController<int>();
  @Output()
  Stream<int> get rmVal_e => _innerListControllerRmVal.stream;
  final _innerListControllerRmType = StreamController<String>();
  @Output()
  Stream<String> get rmType_e => _innerListControllerRmType.stream;
  final _innerListControllerRmOp = StreamController<String>();
  @Output()
  Stream<String> get rmOp_e => _innerListControllerRmOp.stream;
  final _innerListControllerRm = StreamController<int>();
  @Output()
  Stream<int> get rm_e => _innerListControllerRm.stream;
  void rmFMC(String type, String op, int val){
    _innerListControllerRmType.add(type);
    _innerListControllerRmOp.add(op);
    _innerListControllerRmVal.add(val);
    _innerListControllerRm.add(1);
    FS.rm(type, op, val);
  }

  final _innerListControllerColumnText = StreamController<String>();
  @Output()
  Stream<String> get columnText_e => _innerListControllerColumnText.stream;
  final _innerListControllerOperatorsText = StreamController<String>();
  @Output()
  Stream<String> get operatorsText_e => _innerListControllerOperatorsText.stream;
  final _innerListControllerValueText = StreamController<int>();
  @Output()
  Stream<int> get valueText_e => _innerListControllerValueText.stream;

  final _innerListControllerAdd = StreamController();
  @Output()
  Stream get add_e => _innerListControllerAdd.stream;


  void addFMC(String columnText, String operatorsText, int valueText){
//    print('------');
    if(valueText != null){
      FS.add(columnText, operatorsText, valueText);

      _innerListControllerColumnText.add(columnText);
      _innerListControllerOperatorsText.add(operatorsText);
      _innerListControllerValueText.add(valueText);

      _innerListControllerAdd.add(1);

    }
  }

}

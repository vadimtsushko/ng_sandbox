import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'dart:async';
import 'dart:html';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';
import 'package:angular_tour_of_heroes/src/components/filter/filter.dart';


@Component(
  selector: 'my-filterModal',
  templateUrl: 'filterModal.html',
  styleUrls: ['filterModal.css'],
  directives: [coreDirectives, routerDirectives, formDirectives,  FilterComponent],
)

class FilterModalComponent extends FilterComponent {

  void openFMC(){
    FS.reset();

    var value = (querySelector('#value') as InputElement);
    value.value = "";

    var operators = (querySelector('#operators') as SelectElement);
    operators.value = "";

    var column = (querySelector('#column') as SelectElement);
    column.value = "";
  }

  void resetFMC(){
    FS.reset();
//    streamEventProcessing(new Data('reset', []));
  }

  void rmFMC(String type, String op, int val){
    FS.rm(type, op, val);
  }

  void addFMC(String columnText, String operatorsText, int valueText){
    if(valueText != null){
      FS.add(columnText, operatorsText, valueText);
    }
  }

  void applyFMC(){
    streamEventProcessing(new Data('apply', FS.filter));
  }
  
  @Output()
  Stream get streamEventProcessing_e => _innerListController_streamEventProcessing.stream;
  final _innerListController_streamEventProcessing = StreamController();
  void streamEventProcessing(Data e){
    _innerListController_streamEventProcessing.add(e);
  }

}

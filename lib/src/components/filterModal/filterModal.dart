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
  directives: [coreDirectives, routerDirectives, formDirectives],
)

//class FilterModalComponent extends FilterComponent {
class FilterModalComponent {

  FilterSelector FS = new FilterSelector()..init();

  String columnText;
  String operatorsText;
  int valueText;

  void openFMC(){
    FS.reset();
    columnText = '';
    operatorsText = '';
    valueText = null;
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
    streamEventProcessing(new Data(ActionTypes.APPLY, FS.filter));
  }

  @Output()
  Stream get streamEventProcessing_e => _innerListController_streamEventProcessing.stream;
  final _innerListController_streamEventProcessing = StreamController();
  void streamEventProcessing(Data e){
    _innerListController_streamEventProcessing.add(e);
  }

}

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

  void resetFMC(){
    FS.reset();
    streamEventProcessing(new Data('reset', []));
  }

  void rmFMC(String type, String op, int val){
    FS.rm(type, op, val);
    streamEventProcessing(new Data('rm', [type, op, val]));
  }

  void addFMC(String columnText, String operatorsText, int valueText){
    if(valueText != null){
      FS.add(columnText, operatorsText, valueText);
      streamEventProcessing(new Data('add', [columnText, operatorsText, valueText]));
    }
  }

  @Output()
  Stream get streamEventProcessing_e => _innerListController_streamEventProcessing.stream;
  final _innerListController_streamEventProcessing = StreamController();
  void streamEventProcessing(Data e){
    _innerListController_streamEventProcessing.add(e);
  }



}

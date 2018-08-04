import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'dart:async';
import 'dart:html';


import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';

@Component(
  selector: 'my-filterModal',
  templateUrl: 'filterModal.html',
  styleUrls: ['filterModal.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
)

class FilterModalComponent {

  FilterSelector selector = new FilterSelector()..init();

  int filterLength = 0;
  bool btnDisabled = true;

  bool points = false;

  bool status =  false;

  bool isUnchanged = false;

  void openFMC(){
    selector.reset();
  }

  void resetFMC(){
    selector.reset();
    filterLength = 0;
  }

  void rmFMC(String measures, String dimensions, String operator, int value){
    selector.rm(measures, dimensions, operator, value);
    filterLength--;
  }

  void addFMC(String measures, String dimensions, String operator, int value){
    if(measures != null && dimensions != null && operator != null && value != null ){
      selector.add(measures, dimensions, operator, value);
      filterLength++;
    }
  }

  void applyFMC(){
    streamEventProcessing(new Data(ActionType.apply, selector.filter));
  }

  @Output()
  Stream get streamEventProcessing_e => _innerListController_streamEventProcessing.stream;
  final _innerListController_streamEventProcessing = StreamController();
  void streamEventProcessing(Data e){
    _innerListController_streamEventProcessing.add(e);
  }

}

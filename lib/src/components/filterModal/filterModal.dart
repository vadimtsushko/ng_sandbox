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

  FilterSelector FS = new FilterSelector()..init();

  String operator;
  String measures;
  String dimensions;
  int value;
  int filterLength = 0;
  bool btnDisabled = true;

  bool points = false;


  @Input('myHighlight')
  String highlightColor;
  setUppercaseName(sss){
//    print('---');
//    print(sss);
  }
  canAdd(){
    print('${dimensions} - ${measures}');
//
////    bool res = false;
//    if(dimensions == '' || measures == ''){
//      res = false;
//    } else {
//      print(FS.filter);
//    }

//    var el = (querySelector('#addFilter') as ButtonElement);
//    el.disabled = res;
  }

  void openFMC(){
    FS.reset();
    dimensions = '';
    operator = '';
    measures = '';
  }

  void resetFMC(){
    FS.reset();
    filterLength = 0;
  }

  void rmFMC(String measures, String dimensions, String operator, int value){
    FS.rm(measures, dimensions, operator, value);
    filterLength--;
  }

  void addFMC(String measures, String dimensions, String operator, int value){
    if(measures != null && dimensions != null && operator != null && value != null ){
      FS.add(measures, dimensions, operator, value);
      filterLength++;
    }
  }

  void applyFMC(){
    streamEventProcessing(new Data(ActionType.apply, FS.filter));
  }

  @Output()
  Stream get streamEventProcessing_e => _innerListController_streamEventProcessing.stream;
  final _innerListController_streamEventProcessing = StreamController();
  void streamEventProcessing(Data e){
    _innerListController_streamEventProcessing.add(e);
  }

}

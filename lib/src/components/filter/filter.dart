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

class FilterComponent implements OnInit {

  FilterSelector FS = new FilterSelector()..init();

  String columnText;
  String operatorsText;
  int valueText;

  Future<void> ngOnInit() async {
    columnText  = FS.headers[0] ?? '';
    operatorsText = FS.operators[0] ?? '';
  }

  streamEventProcessing(Data e){
    if(e.type == ActionTypes.RM){
      FS.rm(e.params[0], e.params[1], e.params[2]);
    } else if( e.type == ActionTypes.ADD){
      FS.add(e.params[0], e.params[1], e.params[2]);
    } else if( e.type == ActionTypes.RESET){
      FS.reset();
    } else if( e.type == ActionTypes.APPLY){
      FS.filter = e.params;
      FS.filterOut();
    }
  }

}


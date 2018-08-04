import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:model/model.dart';
import 'dart:async';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';
import 'package:tuple/tuple.dart';

@Component(
  selector: 'my-filterModal',
  templateUrl: 'filterModal.html',
  styleUrls: ['filterModal.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
)
class FilterModalComponent {
  FilterSelector selector = new FilterSelector();
  @Output()
  Stream<Tuple2<String, List<FilterData>>> get onApply =>
      selector.applyStreamController.stream;
  @Input()
  set measures(value) => selector.measures = value;
  @Input()
  set dimensions(value) => selector.dimensions = value;
}

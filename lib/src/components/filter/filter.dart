import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';
import 'package:angular_tour_of_heroes/src/components/filterModal/filterModal.dart';

@Component(
  selector: 'my-filter',
  templateUrl: 'filter.html',
  styleUrls: ['filter.css'],
  directives: [coreDirectives, routerDirectives, formDirectives, FilterModalComponent],
)

class FilterComponent {

  FilterSelector selector = new FilterSelector()..init();

}


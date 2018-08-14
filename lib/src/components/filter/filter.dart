import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:model/model.dart';

import 'package:ng_sandbox/src/app_controller/filter_selector.dart';
import 'package:tuple/tuple.dart';
import 'package:ng_sandbox/src/components/filterModal/filterModal.dart';

@Component(
  selector: 'my-filter',
  templateUrl: 'filter.html',
  styleUrls: ['filter.css'],
  directives: [coreDirectives, routerDirectives, formDirectives, FilterModalComponent],
)

class FilterComponent {
  List<IvMasterExpression> measures;
  List<IvMasterDimension> dimensions;
  FilterComponent() {
    measures = testMeasures
        .map((map) => fromJson<IvMasterExpression>(IvMasterExpression, map))
        .toList();
    dimensions = testDimensions
        .map((map) => fromJson<IvMasterDimension>(IvMasterDimension, map))
        .toList();
  }

  onApply(Tuple2<String, List<FilterData>> event) {
    print('Get new filter: $event');
  }
}


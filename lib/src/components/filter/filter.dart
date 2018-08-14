import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:model/model.dart';

import 'package:ng_sandbox/src/components/filterModal/filterModal.dart';
import 'package:ng_sandbox/src/app_controller/event_bus.dart';
import 'filter_test_data.dart';

@Component(
  selector: 'my-filter',
  templateUrl: 'filter.html',
  styleUrls: ['filter.css'],
  directives: [
    coreDirectives,
    routerDirectives,
    formDirectives,
    FilterModalComponent
  ],
)
class FilterComponent {
  EventBus eventBus;

  FilterComponent(this.eventBus) {}

  showDialog() {
    var event = MeasureFilterDialogEvent()
      ..measures = testMeasures
          .map((map) => fromJson<MeasureForFilter>(MeasureForFilter, map))
          .toList()
      ..dimensions = testDimensions
          .map((map) => fromJson<IvMasterDimension>(IvMasterDimension, map))
          .toList();
    eventBus.showMeasureFilterDialog.add(event);
  }

  onApply(MeasureFilterEvent event) {
    print('Get new filter: $event');
  }
}

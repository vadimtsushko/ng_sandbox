import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'dart:html';
import 'package:model/model.dart';
import 'dart:async';

import './filterInput/filter_input.dart';
import 'filter_selector.dart';
import 'package:ng_sandbox/src/app_controller/event_bus.dart';


@Component(
  selector: 'filter-modal',
  templateUrl: 'filter-modal.html',
  styleUrls: ['filter-modal.css'],
  directives: [coreDirectives, routerDirectives, formDirectives, FilterInputComponent],
)

class FilterModalComponent implements AfterViewInit {

  ElementRef elementRef;
  EventBus   eventBus;
  FilterSelector selector = new FilterSelector();
  @Output()
  Stream<MeasureFilterEvent> get onApply =>
      selector.applyStreamController.stream;
  @Input()
  set measures(value) {
    selector.measures = value;
  }
  @Input()
  set dimensions(value) => selector.dimensions = value;
  FilterModalComponent(this.elementRef, this.eventBus) {
  }

  ngAfterViewInit() {
    eventBus.showMeasureFilterDialog.listen(showModal);
  }
  showModal(MeasureFilterDialogEvent event) {
    measures = event.measures;
    dimensions = event.dimensions;
    selector.reset();
    Element element = elementRef.nativeElement;
    ButtonElement buttonElement = element.querySelector('#filterModalOpen');
    buttonElement.click();
  }



}

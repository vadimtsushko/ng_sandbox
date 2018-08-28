import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:ng_sandbox/src/components/dimensions/dimensions.dart';

@Component(
  selector: 'page_control',
  templateUrl: 'page_control.html',
  styleUrls: ['page_control.css'],
  directives: [coreDirectives,  routerDirectives, formDirectives, DimensionsComponent],
)


class PageControlComponent {
  bool isSearchActive  = false;
  void searchClickHandler () => isSearchActive = !isSearchActive;
  PageControlComponent();

}



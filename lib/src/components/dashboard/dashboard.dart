import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:angular_tour_of_heroes/src/components/dimensions/dimensions.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard.html',
  styleUrls: ['dashboard.css'],
  directives: [coreDirectives,  routerDirectives, formDirectives, DimensionsComponent],
)


class DashboardComponent {

  DashboardComponent();

}


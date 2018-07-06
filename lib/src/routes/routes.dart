import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:angular_tour_of_heroes/src/routes/route_paths.dart' as paths;
//import 'hero_list_component.template.dart' as hlct;
import '../components/dashboard/dashboard.template.dart' as dashboard_template;
import '../components/builder/builder.template.dart' as builder_template;
//import 'hero_component.template.dart' as hct;

@Injectable()
class Routes {
  RoutePath get builder => paths.builder ;
  RoutePath get dashboard => paths.dashboard;
  final List<RouteDefinition> all = [
    RouteDefinition(
      path: paths.dashboard.path,
      component: dashboard_template.DashboardComponentNgFactory,
    ),
    RouteDefinition(
      path: paths.builder.path,
      component: builder_template.BuilderComponentNgFactory,
    ),
    RouteDefinition.redirect(path: '', redirectTo: paths.dashboard.toUrl()),
  ];

}
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:ng_sandbox/src/routes/route_paths.dart' as paths;
//import 'hero_list_component.template.dart' as hlct;
import '../components/dashboard/dashboard.template.dart' as dashboard_template;
import '../components/builder/builder.template.dart' as builder_template;
import '../components/filter/filter.template.dart' as filter_template;
import '../components/loading/loading.template.dart' as loading_template;
import '../components/pageControl/page_control.template.dart' as page_control;
//import 'hero_component.template.dart' as hct;

@Injectable()
class Routes {
  RoutePath get builder => paths.builder ;
//  RoutePath get loading => paths.loading ;
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
    RouteDefinition(
      path: paths.loading.path,
      component: loading_template.LoadingComponentNgFactory,
    ),
    RouteDefinition(
      path: paths.filter.path,
      component: filter_template.FilterComponentNgFactory,
    ),
    RouteDefinition(
      path: paths.pageControl.path,
      component: page_control.PageControlComponentNgFactory,
    ),
    RouteDefinition.redirect(path: '', redirectTo: paths.dashboard.toUrl()),

  ];

}


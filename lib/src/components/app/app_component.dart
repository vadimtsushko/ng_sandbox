import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_tour_of_heroes/src/routes/routes.dart';
@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: [routerDirectives],
  providers: [ ClassProvider(Routes),],
)
class AppComponent
{
  final Routes routes;
  final title = 'Tour of Heroes';
  AppComponent(this.routes);
}
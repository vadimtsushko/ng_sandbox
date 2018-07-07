import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_tour_of_heroes/src/routes/routes.dart';
@Component(

  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [routerDirectives],
  providers: [ ClassProvider(Routes),],
)
class AppComponent
{

  final Routes routes;
  AppComponent(this.routes);

}



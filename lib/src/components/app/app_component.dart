import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:ng_sandbox/src/routes/routes.dart';
import 'dart:async';
import 'dart:html';
import 'package:ng_sandbox/src/app_controller/event_bus.dart';

@Component(

  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [routerDirectives],
  providers: [ ClassProvider(Routes),ClassProvider(EventBus)],
)
class AppComponent implements OnInit
{
  String url = '';

  final Routes routes;
  AppComponent(this.routes);

  setUrl(){
    if(window.location.toString().split("#").length > 1){
      this.url = window.location.toString().split("#")[1];
      this.url = this.url.replaceAll(new RegExp(r'-'), ' ');
      this.url = this.url.replaceAll(new RegExp(r'/'), '');
    } else {
      this.url = 'dashboard';
    }
  }

  Future<void> ngOnInit() async {
    this.setUrl();
    window.onPopState.listen((PopStateEvent e) {
      this.setUrl();
    });
  }
}



import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_tour_of_heroes/src/components/app/app_component.template.dart' as ng;
import 'main.template.dart' as self;

@GenerateInjector([
  routerProvidersHash, // You can use routerProviders in production
  // Using a real back end?
  // Import 'package:http/browser_client.dart' and change the above to:
  //   ClassProvider(Client, useClass: BrowserClient),
])
//    ClassProvider(BrowserClient),]

final InjectorFactory injector = self.injector$Injector;

//var aaa = 'Показать измерения';
void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}

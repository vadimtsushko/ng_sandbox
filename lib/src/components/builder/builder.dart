import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';

@Component(
  selector: 'my-builder',
  templateUrl: 'builder.html',
  styleUrls: ['builder.css'],
  directives: [coreDirectives,  routerDirectives],
)
class BuilderComponent implements OnInit {


  BuilderComponent();

  Future<void> ngOnInit() async {
  }
}
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard.html',
  styleUrls: ['dashboard.css'],
  directives: [coreDirectives,  routerDirectives],
)
class DashboardComponent implements OnInit {


  DashboardComponent();

  Future<void> ngOnInit() async {
  }
}
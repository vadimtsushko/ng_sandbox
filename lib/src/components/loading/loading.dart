import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'dart:io';
import 'dart:html';
import 'dart:math' show Random;

@Component(
  selector: 'my-loading',
  templateUrl: 'loading.html',
  styleUrls: ['loading.css'],
  directives: [coreDirectives,  routerDirectives],
)
class LoadingComponent implements OnInit {

  int progress = 0;
  bool isProgressRun = false;

  LoadingComponent();

  Future<void> ngOnInit() async {
  }

  download(){
    isProgressRun = true;
    new Timer( const Duration(milliseconds: 500), () => progressPlus());
  }
  cancel(){
    progress = 0;
    isProgressRun = false;
  }
  progressPlus(){

    if(progress < 100 && isProgressRun){
      progress += 10;
      new Timer( const Duration(milliseconds: 500), () => progressPlus());
    } else if(progress == 100 && isProgressRun){
      String encodedFileContents = Uri.encodeComponent("Hello World!");

      new AnchorElement(href: "data:text/plain;charset=utf-8,$encodedFileContents")
        ..setAttribute("download", "file.txt")
        ..click();
    }

  }
}
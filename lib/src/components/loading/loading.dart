import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'dart:io';
import 'dart:html' as html;

import 'dart:async';
import 'package:http/browser_client.dart';



@Component(
  selector: 'my-loading',
  templateUrl: 'loading.html',
  styleUrls: ['loading.css'],
  directives: [coreDirectives,  routerDirectives],
)
class LoadingComponent implements OnInit {

  int progress = 0;
  int part = 0;
  bool isProgressRun = false;

  String result = '';

  LoadingComponent();


  Future<void> ngOnInit() async {
  }



  download() {
    isProgressRun = true;
    progressPlus();

  }
  cancel(){
    isProgressRun = false;
    progress = 0;
    part = 0;
  }
  progressPlus({int p = 1}) async {
   if(isProgressRun){
     var client = new BrowserClient();
     var url = 'http://localhost:4040/?part=${p}';
     var response =
     await client.post(url);

     result += response.body;

     p += 1;
     if(p < 4){
       progressPlus(p: p);
       progress = p  * 30;
       if(p > 2)
         progress =100;
     } else {
       String encodedFileContents = Uri.encodeComponent("Hello World!");
       new html.AnchorElement(href: "data:text/plain;charset=utf-8,$encodedFileContents")
         ..setAttribute("download", "file.txt")
         ..click();
     }

   }



  }
}
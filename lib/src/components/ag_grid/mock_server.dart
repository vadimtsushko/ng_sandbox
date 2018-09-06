import 'package:ag_grid/ag_grid.dart';
import 'dart:js';
import 'dart:js_util';
import 'dart:html' as html;

class MockServer {
  IEnterpriseDatasource datasource;
  List data;

  void getRows( params) {
    html.window.console.log(params);
    html.window.console.log(params.request);
//    print(params.request);
    var rows = List.from(jsify(data.sublist(
        params.request.startRow, params.request.endRow)) as Iterable);
//    params.successCallback(rows, -1);
  }

   getDatasource() {
//    var result = new IEnterpriseDatasource();
    var result = new IServerSideDatasource();
//    html.window.console.log(allowInterop(this.getRows));
//    html.window.console.log(123);F
    result.getRows = allowInterop(this.getRows);
    return result;
  }

  setData(List allData) {
    data = allData;
  }

}
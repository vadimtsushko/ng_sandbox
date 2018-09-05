import 'package:ag_grid/ag_grid.dart';
import 'dart:js';
import 'dart:js_util';
class MockServer {
  IEnterpriseDatasource datasource;
  List data;

  void getRows(IEnterpriseGetRowsParams params) {
    var rows = List.from(jsify(data.sublist(
        params.request.startRow, params.request.endRow)) as Iterable);
    params.successCallback(rows, -1);
  }

  IEnterpriseDatasource getDatasource() {
    var result = new IEnterpriseDatasource();
    result.getRows = allowInterop(this.getRows);
    return result;
  }

  setData(List allData) {
    data = allData;
  }

}
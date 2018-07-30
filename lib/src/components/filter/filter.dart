import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'dart:html';

import 'package:angular_tour_of_heroes/src/app_controller/filter_selector.dart';


@Component(
  selector: 'my-filter',
  templateUrl: 'filter.html',
  styleUrls: ['filter.css'],
  directives: [coreDirectives, routerDirectives],
)

class FilterComponent implements OnInit, OnChanges {
//  List<String> headers;
//  List<List> dataIn;
//  List<List> dataOut;
//  List<List> filter;
//  List<String> operators = ['<', '>', '<=', '>=', '=='];

  Future<void> ngOnInit() async {
//    this.init();
  }
//TODO: Почему не отрабатывает?
  Future<void> ngOnChanges(Map<String, SimpleChange> changes) async {
    print('ngOnChanges');
  }

//  init({headers = testHeaders, data = testData, filter = testFilter}) {
//    this.headers = List.from(headers);
//    this.dataIn = List.from(data);
//    this.filter = List.from(filter);
//    filterOut();
//  }

//  void reset() {
//    filter = [];
//    filterOut();
//  }

//  void add() {
//    var columnText = getColumnText();
//    var operatorsText = getOperatorsText();
//    var valueText = getValueText();
//    if (valueText.length > 0) {
//      filter.add([columnText, operatorsText, int.parse(valueText)]);
//      filterOut();
//    }
//  }

  FilterSelector FS = new FilterSelector()..init();

  String getColumnText() {
    var column = (querySelector('#column') as SelectElement);
    return column.value;
  }

  String getOperatorsText() {
    var operators = (querySelector('#operators') as SelectElement);
    return operators.value;
  }

  String getValueText() {
    var value = (querySelector('#value') as InputElement);
    return value.value;
  }
  void add() {
    var columnText = getColumnText();
    var operatorsText = getOperatorsText();
    var valueText = getValueText();
    if (valueText.length > 0) {
      FS.filter.add([columnText, operatorsText, int.parse(valueText)]);
      FS.filterOut();
    }
  }
//  rmOneFilter(List text){
//    print(text[0]);
//    filter.remove(text);
//    filterOut();
//  }

//  filterOut() {
//    List<List> out = [];
//    for (int i = 0; i < dataIn.length; i++) {
//      var isAdd = true;
//      for (int j = 0; j < filter.length; j++) {
//        int position = _getColPosition(filter[j][0]);
////        int position = 0;
//        int valData = dataIn[i][position];
//        var valOpr = filter[j][1];
//        int filterData = filter[j][2];
//        isAdd = isCanAdd(valData, valOpr, filterData);
//      }
//      if (isAdd) {
//        out.add(dataIn[i]);
//      }
//    }
//    dataOut = out;
//  }

//  int _getColPosition(colText) {
//    var position = 0;
//    for (int h = 0; h < headers.length; h++) {
//      if (headers[h] == colText) {
//        position = h;
//      }
//    }
//    return position;
//  }


}

const List<String> testHeaders = ['Сумма продаж тыс.руб', 'Наценка, тыс. руб', 'Остатки, тыс руб', 'Количество продано, шт'];
const List<List> testData = [
  [1, 4, 1, 0],
  [2, 3, 2,  1],
  [3, 2, 3, 4],
  [4, 1, 4, 10]
];
const List<List> testFilter = [
  ['col1', '==', 3],
//  ['col1', '>', 2],
];

import 'package:model/model.dart';

part 'filter_test_data.dart';


class NonExistentOperator implements Exception {
  final String msg;

  const NonExistentOperator([this.msg]);

  @override
  String toString() => msg ?? 'NonExistentOperator';
}

class Data{
  ActionType type;
  List params;
  Data(this.type, this.params);
}

enum ActionType {
  add,
  remove,
  reset,
  apply
}
//class ActionTypes {
//  static const ADD = 'ADD';
//  static const RM = 'RM';
//  static const RESET = 'RESET';
//  static const APPLY = 'APPLY';
//}

class FilterSelector {
  List<IvMasterExpression> measures;
  List<IvMasterDimension> dimensions;

  List<String> headers;
  List<List<int>> dataIn;
  List<List<int>> dataOut;
  List<DataFilter>  filter;
  List<String> operators = ['<', '>', '<=', '>=', '=='];

  init({List<String> headers = testHeaders, List<List<int>> data = testData, List<DataFilter> filter = testFilter}) {
    this.headers = List.from(headers);
    this.dataIn = List.from(data);
    this.filter = List.from(filter);
    measures = testMeasures.map((map)=>fromJson<IvMasterExpression>(IvMasterExpression, map)).toList();
    dimensions = testDimensions.map((map)=>fromJson<IvMasterDimension>(IvMasterDimension, map)).toList();
    print(dimensions.length);
    filterOut();
  }

  bool isCanAdd(int valData,String operator,int filterData) {
    var res = false;
    if (operator == '<') {
      res = valData < filterData;
    } else if (operator == '>') {
      res = valData > filterData;
    } else if (operator == '<=') {
      res = valData <= filterData;
    } else if (operator == '>=') {
      res = valData >= filterData;
    } else if (operator == '==') {
      res = (valData == filterData);
    } else {
      throw NonExistentOperator();
    }
    return res;
  }

  void rm(String type, String op, int val){
    for(int i = 0; i < filter.length; i++){
      if(type == filter[i].column && op == filter[i].operator && val == filter[i].value){
        filter.removeAt(i);
      }
    }
    filterOut();
  }

  void reset() {
    filter = [];
    filterOut();
  }

  void filterOut() {
    List<List<int>> out = [];
    for (int i = 0; i < dataIn.length; i++) {
      var isAdd = true;
      for (int j = 0; j < filter.length; j++) {
        int position = _getColPosition(filter[j].column);
        int valData = dataIn[i][position];
        var valOpr = filter[j].operator;
        int filterData = filter[j].value;
        isAdd = isCanAdd(valData, valOpr, filterData);
      }
      if (isAdd) {
        out.add(dataIn[i]);
      }
    }
    dataOut = out;
  }

  int _getColPosition(String colText) {
    var position = 0;
    for (int h = 0; h < headers.length; h++) {
      if (headers[h] == colText) {
        position = h;
      }
    }
    return position;
  }

  void add(String columnText, String operatorsText, int valueText) {
    if(valueText != null){
      filter.add( DataFilter(columnText,operatorsText,valueText));
      filterOut();
    }
  }

}


const List<String> testHeaders = ['Сумма продаж тыс.руб', 'Наценка, тыс. руб', 'Остатки, тыс руб', 'Количество продано, шт'];
const List<List<int>> testData = [
  [1, 4, 1, 0],
  [2, 3, 2,  1],
  [3, 2, 3, 4],
  [4, 1, 4, 10]
];

class DataFilter{
  final String column;
  final String operator;
  final int value;
  const DataFilter(this.column, this.operator, this.value);
}

const testFilter =  [
  DataFilter('sdf', '>=', 5),
  DataFilter('dfgdfg', '<=', 3)
];

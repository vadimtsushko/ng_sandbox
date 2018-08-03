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

class FilterSelector {
  List<IvMasterExpression> measures;
  List<IvMasterDimension> dimensions;

  List<String> headers;
  List<List<int>> dataOut;
  List<DataFilter>  filter;
  List<String> operators = ['<', '>', '<=', '>=', '=='];



  init({List<String> headers = testHeaders, List<List<int>> data = testData}) {
    this.headers = List.from(headers);
    measures = testMeasures.map((map)=>fromJson<IvMasterExpression>(IvMasterExpression, map)).toList();
    dimensions = testDimensions.map((map)=>fromJson<IvMasterDimension>(IvMasterDimension, map)).toList();
  }

  canAdd(){

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

  void rm(String measures, String dimensions, String operator, int value){
    for(int i = 0; i < filter.length; i++){
      if(measures == filter[i].measures && dimensions == filter[i].dimensions && operator == filter[i].operator && value == filter[i].value){
        filter.removeAt(i);
      }
    }
  }

  void reset() {
    filter = [];
    filterOut();
  }

  void filterOut() {
  }

  void add(String measures, String dimensions, String operator, int value) {
    filter.add( DataFilter(measures,dimensions,operator,value));
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
  final String measures;
  final String dimensions;
  final String operator;
  final int value;
  const DataFilter(this.measures, this.dimensions, this.operator, this.value);
}

const testFilter =  [
//  DataFilter('sdf', '>=', 5),
//  DataFilter('dfgdfg', '<=', 3)
];

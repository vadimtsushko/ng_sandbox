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

  String _operator;
  String get operator => _operator;
  set operator(String value) {
    _operator = value;
    setBtnStatus();
  }

  String _measure;
  String get measure => _measure;
  set measure(String value) {
    _measure = value;
    setBtnStatus();
  }

  String dimension;

  int value;
  bool canAdd = false;
  List<IvMasterExpression> measures;
  List<IvMasterDimension> dimensions;

  List<String> headers;
  List<List<int>> dataOut;
  List<DataFilter>  filter = [];
  List<String> operators = ['<', '>', '<=', '>=', '=='];

  int get filterLenght => filter.length;

  bool btnStatus = false;

  init({List<String> headers = testHeaders, List<List<int>> data = testData}) {
    this.headers = List.from(headers);
    measures = testMeasures.map((map)=>fromJson<IvMasterExpression>(IvMasterExpression, map)).toList();
    dimensions = testDimensions.map((map)=>fromJson<IvMasterDimension>(IvMasterDimension, map)).toList();
  }

  void setBtnStatus(){
//    print('changeBtnStatus ${checkCanAdd()}');
    btnStatus = !checkCanAdd();
  }

  bool checkCanAdd() {
    bool res = true;
    if(measure == '' || operator == ''){
      res = false;
    } else {
      for(int i = 0; i < filter.length; i++){
        if(filter[i].measures == measure && filter[i].operator == operator){
          res = false;
        }
      }
    }
    return res;
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
    dimension = '';
    operator = '';
    measure = '';
    filter = [];
    filterOut();
  }

  void filterOut() {
  }

  void add(String measures, String dimensions, String operator, int value) {
    filter.add( DataFilter(measures,dimensions,operator,value));
    setBtnStatus();
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

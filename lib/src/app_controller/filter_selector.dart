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

  String _dimension;
  String get dimension => _dimension;
  set dimension(String value) {
    _dimension = value;
    setBtnStatus();
  }

  int _value;
  int get value => _value;
  set value(int value) {
    _value = value;
    setBtnStatus();
  }

  bool canAdd = false;
  List<IvMasterExpression> measures;
  List<IvMasterDimension> dimensions;

  List<String> headers;
  List<List<int>> dataOut;
  List<DataFilter>  filter = [];
  List<String> operators = ['<', '>', '<=', '>=', '=='];

  int get filterLength => filter.length;

  bool btnStatus = false;

  init({List<String> headers = testHeaders, List<List<int>> data = testData}) {
    this.headers = List.from(headers);
    measures = testMeasures.map((map)=>fromJson<IvMasterExpression>(IvMasterExpression, map)).toList();
    dimensions = testDimensions.map((map)=>fromJson<IvMasterDimension>(IvMasterDimension, map)).toList();
  }

  apply(){
    print('apply');
  }

  void setBtnStatus(){
    btnStatus = !checkCanAdd();
  }

  bool checkCanAdd() {
    bool res = true;

    if(measure == '' || operator == '' || dimension == '' || value == null){
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

  void rm(String m, String o, int v){
    print('${m} - ${o} ');
    for(int i = 0; i < filter.length; i++){
      if(m == filter[i].measures && o == filter[i].operator && v == filter[i].value){
        filter.removeAt(i);
      }
    }
    setBtnStatus();
  }

  void reset() {
    dimension = '';
    operator = '';
    measure = '';
    filter = [];
    setBtnStatus();
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

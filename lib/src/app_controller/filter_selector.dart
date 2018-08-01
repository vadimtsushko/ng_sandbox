class NonExistentOperator implements Exception {
  final String msg;

  const NonExistentOperator([this.msg]);

  @override
  String toString() => msg ?? 'NonExistentOperator';
}

class Data{

  String type;

  List params;

  Data(this.type, this.params);
}

class FilterSelector {

  List<String> headers;
  List<List> dataIn;
  List<List> dataOut;
  List<List> filter;
  List<String> operators = ['<', '>', '<=', '>=', '=='];

  init({List<String> headers = testHeaders, List<List> data = testData, List<List> filter = testFilter}) {
    this.headers = List.from(headers);
    this.dataIn = List.from(data);
    this.filter = List.from(filter);
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
      if(type == filter[i][0] && op == filter[i][1] && val == filter[i][2]){
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
    List<List> out = [];
    for (int i = 0; i < dataIn.length; i++) {
      var isAdd = true;
      for (int j = 0; j < filter.length; j++) {
        int position = _getColPosition(filter[j][0]);
        int valData = dataIn[i][position];
        var valOpr = filter[j][1];
        int filterData = filter[j][2];
        isAdd = isCanAdd(valData, valOpr, filterData);
      }
      if (isAdd) {
        out.add(dataIn[i]);
      }
    }
    dataOut = out;
//    print(dataOut);
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
      filter.add([columnText, operatorsText, valueText]);
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
const List<List> testFilter = [
  ['Количество продано, шт', '>=', 3],
//  ['col1', '>', 2],
];

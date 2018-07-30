//class AvailException implements Exception {
//  final String msg;
//
//  const AvailException([this.msg]);
//
//  @override
//  String toString() => msg ?? 'AvailException';
//}

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
    }
    return res;
  }

  void rmOneFilter(List text){
    print('---------');
    print(text);
    print('---------');
    filter.remove(text);
    print('---------');
    print(filter);
    print('---------');
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
}


const List<String> testHeaders = ['Сумма продаж тыс.руб', 'Наценка, тыс. руб', 'Остатки, тыс руб', 'Количество продано, шт'];
const List<List> testData = [
  [1, 4, 1, 0],
  [2, 3, 2,  1],
  [3, 2, 3, 4],
  [4, 1, 4, 10]
];
const List<List> testFilter = [
  ['Количество продано, шт', '>=', 3],
//  ['col1', '>', 2],
];

import 'dart:html';
import 'package:ag_grid/ag_grid.dart';
import 'package:ag_grid/js_object_api.dart' as js_object_api;
import 'package:ag_grid/filters/date_filter_factory.dart';
import "dart:js";
import 'package:ag_grid/interop/dart_interface.dart';
import "package:js/js.dart";
import 'data.dart';
import 'dart:async';

var cellStyleBoolean = new JsObject.jsify({'text-align': 'center'});
var rowData = [
  new CarItem(
      make: 'Hyundai',
      model: 'Solaris',
      price: 625000,
      topSeller: '1',
      makeDate: new DateTime(2015, 1, 1)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'Sonata',
      price: 1245000,
      topSeller: '1',
      makeDate: new DateTime(2017, 2, 2)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'Creta',
      price: 799000,
      topSeller: '1',
      makeDate: new DateTime(2014, 3, 3)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'Elantra',
      price: 957000,
      topSeller: '1',
      makeDate: new DateTime(2012, 4, 4)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'Tucson',
      price: 1449900,
      topSeller: '1',
      makeDate: new DateTime(2011, 5, 5)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'Santa fe',
      price: 1856000,
      topSeller: '1',
      makeDate: new DateTime(2013, 6, 6)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'Grand Santa fe',
      price: 2324000,
      topSeller: '1',
      makeDate: new DateTime(2011, 7, 7)
  ),
  new CarItem(
      make: 'Hyundai',
      model: 'H-1',
      price: 1954000,
      topSeller: '1',
      makeDate: new DateTime(2015, 8, 8)
  ),
  new CarItem(
      make: 'Skoda',
      model: 'Rapid',
      price: 611000,
      topSeller: '1',
      makeDate: new DateTime(2009, 9, 9)
  ),
  new CarItem(
      make: 'Skoda',
      model: 'Octavia',
      price: 940000,
      topSeller: '1',
      makeDate: new DateTime(2010, 10, 10)
  ),
  new CarItem(
      make: 'Skoda',
      model: 'Yeti',
      price: 1069000,
      topSeller: '1',
      makeDate: new DateTime(2016, 11, 11)
  ),
  new CarItem(
      make: 'Skoda',
      model: 'KODIAQ',
      price: 1999000,
      topSeller: '1',
      makeDate: new DateTime(2012, 12, 12)
  ),
  new CarItem(
      make: 'Skoda',
      model: 'Superb',
      price: 1300000,
      topSeller: '1',
      makeDate: new DateTime(2013, 12, 13)
  ),
  new CarItem(
      make: 'Mersedes-Benz',
      model: 'A-Class',
      price: 1660000,
      topSeller: '0'
  ),
  new CarItem(
      make: 'Mersedes-Benz',
      model: 'E-Class',
      price: 2960000,
      topSeller: '0'
  ),
  new CarItem(
      make: 'BMW',
      model: '118i',
      price: 1520000,
      topSeller: '0'
  ),
  new CarItem(
      make: 'BMW',
      model: '218i',
      price: 1790000,
      topSeller: '0'
  ),
  new CarItem(
      make: 'Nissan',
      model: 'X-Trail',
      price: 1642000,
      topSeller: '0'
  )
];

GridOptions gridOptions;
var startDateColDef;
void main() {
  DateFilterFactory filterFactory = new DateFilterFactory();
  initialiseAgGridWithWebComponents();
  setupDartInterface();
  var priceColumn = new ColumnDef(
      headerName: 'Price',
      field: 'price',
      editable: true,
      filter: 'number',
      width: 100);
  var gridDiv = querySelector('#myGrid');
  var columnDefs = [
    new ColumnDef(
        headerName: 'Make', field: 'make', filter: 'text', editable: true, width: 150, filterParams: new FilterParams(newRowsAction: 'keep')),
  ];

  gridOptions = new GridOptions(
      columnDefs: columnDefs,
      rowSelection: 'multiple',
      rowDeselection: true,
      suppressCellSelection: false,
      enableServerSideSorting: true,
      enableServerSideFilter: true,
      localeText: russianLocale(),
      enableColResize: true,
      rowModelType: 'infinite',
      onBeforeFilterChanged: allowInterop(beforeFilterChanged),
      onAfterFilterChanged: allowInterop(afterFilterChanged),
      onFilterModified: allowInterop(filterModified),
      onBeforeSortChanged: allowInterop(beforeSortChanged),
      onAfterSortChanged: allowInterop(afterSortChanged));
  new Grid(gridDiv, gridOptions);
  Datasource datasource = new Datasource(getRows: allowInterop(getRows));
  gridOptions.api.setDatasource(datasource);
  gridOptions.api.sizeColumnsToFit();
//  gridOptions.api.addEventListener('cellMouseOut', allowInterop(onCellMouseOut));
  gridOptions.api.addEventListener('cellMouseOver', allowInterop(onCellMouseOver));
}

void onCellMouseOut(CellEvent event) {
//  String value = event.value as String;
  print('mouse out on ${event.value}');
}

void onCellMouseOver( event){
//  String value = event.value as String;
  print('mouse over on ${event.value}');
//  RowNode node = event.node;
//  print('RowNode is $node isSelected ${node.isSelected()}');
//  node.setSelected(!node.isSelected());
}

//void filterModified(dynamic value){
//  print('onFilterModified ${js_object_api.toMap(value)}');
//}

void filterModified(){
  print('onFilterModified');
}

beforeFilterChanged(dynamic value){
  print('onBeforeFilterChanged ${js_object_api.toMap(value)}');
}

afterFilterChanged(dynamic value){
  print('onAfterFilterChanged ${js_object_api.toMap(value)}');
}

beforeSortChanged(dynamic value){
  print('onBeforeSortChanged ${js_object_api.toMap(value)}');
}

afterSortChanged(dynamic value){
  print('onAfterSortChanged ${js_object_api.toMap(value)}');
}

getRows(GetRowsParam params) async {
  print('getRows send data request at ${new DateTime.now()}');

  await new Future.delayed(new Duration(milliseconds: 80), (){
    printSortModelContent(params.sortModel);
    printFilterModelContent(params.filterModel);
    params.successCallback(rowData, rowData.length);
    print('getRows received data response at ${new DateTime.now()}');
  });
}

printSortModelContent(List<SortModelItem> items){
  items.forEach((SortModelItem item) {
    print('sort ${item.sort} by column ${item.colId}');
  });
}

printFilterModelContent(dynamic model){

  Map filter = js_object_api.toMap(model);

  if(filter.isEmpty)
    return;

  for(var column in filter.keys){
    Map settings = js_object_api.toMap(filter[column]);

    String typeKey = settings.keys.elementAt(0);
    String valueKey = settings.keys.elementAt(1);
    print('$column column values should ${settings[typeKey]} ${settings[valueKey]}');
  }
}

String booleanFilterCellRenderer(RendererParam params) {
  if (params.value == '1') {
    return "&#10004;";
  } else if (params.value == '') {
    return "&#10006;";
  } else {
    return params.value.toString();
  }
}

String booleanCellRenderer(RendererParam params) {
  if (params.value == '1') {
    return '&#10004';
  } else {
    return '';
  }
}

boolNewValueHandler(RendererParam params) {
  String value = params.newValue.toString().trim();
  if (value != '') {
    value = '1';
  }
  String fieldName = params.colDef.field;
  js_object_api.setValue(params.data, fieldName, value);
}

String pad2(int value) => value < 10 ? '0$value' : '$value';
String toRussianDate(int milliseconds) {
  if (milliseconds == null) {
    return '';
  }
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(milliseconds);
  return '${pad2(date.day)}.${pad2(date.month)}.${date.year}';
}

String formatDate(DateTime date){

  if(date == null){
    return '';
  }

  return '${pad2(date.day)}.${pad2(date.month)}.${date.year}';
}

dateCellRenderer(RendererParam params) => formatDate(params.value as DateTime);

setDate() {
  FilterApi filterApi = gridOptions.api.getFilterApi(startDateColDef);
  filterApi.setFilter(new DateTime(2012, 12, 31));
  gridOptions.api.onFilterChanged();
}

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
      make: 'Hyundai111',
//      model: 'Solaris',
//      price: 625000,
//      topSeller: '1',
//      makeDate: new DateTime(2015, 1, 1)
  ),
  new CarItem(
      make: 'Hyundai',
//      model: 'Sonata',
//      price: 1245000,
//      topSeller: '1',
//      makeDate: new DateTime(2017, 2, 2)
  ),
  new CarItem(
      make: 'Hyundai',
//      model: 'Creta',
//      price: 799000,
//      topSeller: '1',
//      makeDate: new DateTime(2014, 3, 3)
  ),
  new CarItem(
      make: 'Hyundai',
//      model: 'Elantra',
//      price: 957000,
//      topSeller: '1',
//      makeDate: new DateTime(2012, 4, 4)
  ),
];

GridOptions gridOptions;
//var startDateColDef;
void mainssss() {
  DateFilterFactory filterFactory = new DateFilterFactory();
  initialiseAgGridWithWebComponents();
  setupDartInterface();
  var priceColumn = new ColumnDef(
      headerName: 'Price',
      field: 'athlete',
//      editable: true,
      checkboxSelection: true,
      headerCheckboxSelection: true,
      headerCheckboxSelectionFilteredOnly:true,

      width: 100,



  );

  window.console.log(priceColumn);

  var gridDiv = querySelector('#myGrid');
  var columnDefs = [
    new ColumnDef(
//        headerName: 'Price', field: 'make', filter: 'text',

      headerName: "Price",
      field: "make",
      width: 150,
      checkboxSelection: true,
      headerCheckboxSelection: true,
      headerCheckboxSelectionFilteredOnly:true,

    ),
  ];

  gridOptions = new GridOptions(

    columnDefs: columnDefs,
    suppressRowClickSelection: true,
    enableRangeSelection: true,
    enableCellChangeFlash: true,
    rowSelection: 'multiple',
    rowData: null,
    headerHeight: 0,

//      columnDefs: columnDefs,
//      rowSelection: 'multiple',
//      rowDeselection: true,
//      suppressCellSelection: false,
//      enableServerSideSorting: true,
//      enableServerSideFilter: true,
//      localeText: russianLocale(),
//      enableColResize: true,
      rowModelType: 'infinite',
//      onBeforeFilterChanged: allowInterop(beforeFilterChanged),
//      onAfterFilterChanged: allowInterop(afterFilterChanged),
//      onFilterModified: allowInterop(filterModified),
//      onBeforeSortChanged: allowInterop(beforeSortChanged),
//      onAfterSortChanged: allowInterop(afterSortChanged)
  );
  new Grid(gridDiv, gridOptions);
  Datasource datasource = new Datasource(getRows: allowInterop(getRows));
  gridOptions.api.setDatasource(datasource);
  gridOptions.api.sizeColumnsToFit();
//  gridOptions.api.addEventListener('cellMouseOut', allowInterop(onCellMouseOut));
//  gridOptions.api.addEventListener('cellMouseOver', allowInterop(onCellMouseOver));
}


getRows(GetRowsParam params) async {
  await new Future.delayed(new Duration(milliseconds: 80), (){
    params.successCallback(rowData, rowData.length);
  });
}
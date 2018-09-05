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
  new CarItem(make: '1'),
  new CarItem(make: '2'),
  new CarItem(make: '3'),
  new CarItem(make: '4'),
];

GridOptions gridOptions;
//var startDateColDef;



void mainssss() {
  initialiseAgGridWithWebComponents();
  setupDartInterface();
  FloatingFilterComponentParams sss =  new FloatingFilterComponentParams();
  sss.suppressFilterButton = true;

  var gridDiv = querySelector('#myGrid');
  var columnDefs = [
    new ColumnDef(
      headerName: "Price",
      field: "make",
      width: 150,
      checkboxSelection: true,
      headerCheckboxSelection: true,
      headerCheckboxSelectionFilteredOnly:true,
      floatingFilterComponentParams: sss,


    ),
  ];

  gridOptions = new GridOptions(

    columnDefs: columnDefs,
//    suppressRowClickSelection: true,
//    enableRangeSelection: true,
//    enableCellChangeFlash: true,

    suppressRowClickSelection: true,
    enableRangeSelection: true,
    enableCellChangeFlash: true,
    rowSelection: 'multiple',
    rowData: null,
    headerHeight: 0,
    floatingFilter: true,

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
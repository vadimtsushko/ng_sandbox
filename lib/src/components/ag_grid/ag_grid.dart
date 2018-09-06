import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';
import 'dart:async';
import 'package:ag_grid/ag_grid.dart';

import './test.dart' as test;
import 'dart:html' as html;
import 'mock_server.dart';
import 'dart:convert';
//import "dart:io" as io;

import 'dart:async';
import 'dart:io';

import 'package:ng_sandbox/src/components/dimensions/dimensions.dart';

@Component(
  selector: 'ag-grid',
  templateUrl: 'ag_grid.html',
  styleUrls: ['ag_grid.css'],
  directives: [coreDirectives,  routerDirectives, formDirectives, DimensionsComponent],
)


class AgGridComponent implements AfterViewInit{

  var pageSize = 10;
  GridOptions gridOptions;
  List<Map> allOfTheData;

  bool show = false;
  bool block = false;

  startGrid() async{

    var gridDiv = html.querySelector('#myGrid');
    var columnDefs = [
      new ColumnDef(
          headerName: "Athlete",
          field: "athlete",
          width: 150,
        checkboxSelection: true,
        headerCheckboxSelection: true,
        headerCheckboxSelectionFilteredOnly:true,
      ),
    ];

    var path = 'olympicWinners.json';
    var uri = Uri.parse(html.document.baseUri);
    String url = uri.toString() + path.toString();
    allOfTheData = List<Map>.from(
        json.decode(await html.HttpRequest.getString(url.toString())) as List);

    gridOptions = new GridOptions(
      columnDefs: columnDefs,
      rowModelType: 'enterprise',
      rowSelection: 'multiple',
      headerHeight: 0,
    );

    new Grid(gridDiv, gridOptions);

    var dataServer = new MockServer();
    dataServer.setData(allOfTheData);

    gridOptions.api.sizeColumnsToFit();
    gridOptions.api.setEnterpriseDatasource(dataServer.getDatasource());
  }

  ngAfterViewInit()  {
    new Timer( const Duration(milliseconds: 500), () => startGrid());
  }


}

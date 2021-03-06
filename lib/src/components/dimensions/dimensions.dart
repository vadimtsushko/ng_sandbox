import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'package:angular_forms/angular_forms.dart';
import 'dart:html';

import 'package:ng_sandbox/src/app_controller/dimension_selector.dart';

import 'package:dnd/dnd.dart';

@Component(
  selector: 'my-dimensions',
  templateUrl: 'dimensions.html',
  styleUrls: ['dimensions.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
)
class DimensionsComponent implements OnInit {
  String titleDimensions = 'Показать измерения';



  void dimensionsToggle() {
    if (this.titleDimensions == 'Показать измерения') {
      this.titleDimensions = 'Скрыть измерения';
    } else {
      this.titleDimensions = 'Показать измерения';
    }
    this.dragEvents();
  }

  void toggle(MouseEvent e) {
    HtmlElement elem = e.target;
    elem.classes.toggle('active');
    var isActive = elem.classes.contains('active');
    this.toggleAction(elem, e.ctrlKey, isActive);
  }

  void toggleAction(HtmlElement elem, isCtr, isActive) {
    if (isCtr == false) {
      if (isActive) {
        DS.moveTo('str', elem.text);
      }
    } else {
      if (isActive) {
        DS.moveTo('col', elem.text);
      }
    }
    new Timer(
        const Duration(milliseconds: 20), () => this.dragEventsSelected());
  }

  var isDragEvents = false;
  dragEvents() {
    if (!this.isDragEvents) {
      new Draggable(querySelectorAll('.dndBtn'),
          avatarHandler: new AvatarHandler.clone());
      Dropzone dropzoneStr = new Dropzone(querySelector('.strDimensionsBlock'));
      dropzoneStr.onDrop.listen((DropzoneEvent event) {
        DS.moveTo('str', event.draggableElement.text);
        new Timer(
            const Duration(milliseconds: 20), () => this.dragEventsSelected());
      });
      Dropzone dropzoneCol = new Dropzone(querySelector('.colDimensionsBlock'));
      dropzoneCol.onDrop.listen((DropzoneEvent event) {
        DS.moveTo('col', event.draggableElement.text);
        new Timer(
            const Duration(milliseconds: 20), () => this.dragEventsSelected());
      });
      this.isDragEvents = true;
    }
  }

  dragEventsSelected() {
    new Draggable(querySelectorAll('.rmSelect'),
        avatarHandler: new AvatarHandler.clone());
    Dropzone rmSelect = new Dropzone(querySelectorAll('.rmSelect'));
    rmSelect.onDrop.listen((DropzoneEvent event) {
      DS.sort(event.draggableElement.text, event.dropzoneElement.text);
    });
    rmSelect.onDragLeave.listen((DropzoneEvent event) {
      event.dropzoneElement.style.margin = "1px";
    });
    rmSelect.onDragEnter.listen((DropzoneEvent event) {
      event.dropzoneElement.style.marginLeft = "25px";
    });
  }

  bool isActive(String text) =>
      DS.selectedStr.contains(text) || DS.selectedCol.contains(text);

  void rmFromAll(MouseEvent e) {
    HtmlElement elem = e.target;
    DS.moveTo(null, elem.text);
  }

  DimensionSelector DS = new DimensionSelector()..init();

  Future<void> ngOnInit() async {}

  final _innerList = <String>[];
//  final intV = <int>;
//  int intV = 0;
  final _innerListController = StreamController<List<String>>();
  final _innerListControllerInt = StreamController<int>();
  @Output()
  Stream<List<String>> get innerList => _innerListController.stream;

  @Output()
  Stream<int> get intV => _innerListControllerInt.stream;
  void changeList() {
    _innerList.add(_innerList.length.toString());
    _innerListController.add(List<String>.from(_innerList));

    _innerListControllerInt.add(10);

  }

  DimensionsComponent();
}

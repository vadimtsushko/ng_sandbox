import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'package:angular_forms/angular_forms.dart';
import 'dart:html';

import 'package:angular_tour_of_heroes/src/app_controller/dimension_selector.dart';


import 'package:dnd/dnd.dart';


@Component(
  selector: 'my-dimensions',
  templateUrl: 'dimensions.html',
  styleUrls: ['dimensions.css'],
  directives: [coreDirectives,  routerDirectives, formDirectives],
)


class DimensionsComponent implements OnInit {

  String titleDimensions = 'Показать измерения';

  DimensionsComponent();

  void dimensionsToggle() {
    if(this.titleDimensions == 'Показать измерения'){
      this.titleDimensions = 'Скрыть измерения';
    } else {
      this.titleDimensions = 'Показать измерения';
    }
    this.dragEvents();
  }

  void toggle(MouseEvent e) {

    HtmlElement elem = e.target;

    this.toggleAction(elem, e.ctrlKey);

  }
  void toggleAction(HtmlElement elem, isCtr){
    elem.classes.toggle('active');

    var isActive = elem.classes.contains('active');

    if(isCtr == false) {
      if(isActive){
        DS.selectedStr.add(elem.text);
      }
    } else {
      if(isActive){
        DS.selectedCol.add(elem.text);
      }
    }

    new Timer(const Duration(milliseconds:20), () => this.dragEventsSelected() );

  }

  void toggleRm(MouseEvent e) {
    HtmlElement elem = e.target;

    DS.selectedStr.remove(elem.text);
    DS.selectedCol.remove(elem.text);
  }

  var isDragEvents = false;
  dragEvents(){
    if(!this.isDragEvents){

      new Draggable(querySelectorAll('.dndBtn'),
          avatarHandler: new AvatarHandler.clone());

      Dropzone dropzoneStr = new Dropzone(querySelector('.strDimensionsBlock'));
      dropzoneStr.onDrop.listen((DropzoneEvent event) {
        this.toggleAction(event.draggableElement, false);
        DS.rmDuplicate();
        DS.rmDuplicateFromAnotherList('str');
      });

      Dropzone dropzoneCol = new Dropzone(querySelector('.colDimensionsBlock'));
      dropzoneCol.onDrop.listen((DropzoneEvent event) {
        this.toggleAction(event.draggableElement, true);
        DS.rmDuplicate();
        DS.rmDuplicateFromAnotherList('col');
      });

      this.isDragEvents = true;
    }
  }

  dragEventsSelected(){
    new Draggable(querySelectorAll('.rmSelect'), avatarHandler: new AvatarHandler.clone());
    Dropzone rmSelect = new Dropzone(querySelectorAll('.rmSelect'));
    rmSelect.onDrop.listen((DropzoneEvent event) {
      DS.dragSelectedSort( event.draggableElement.text, event.dropzoneElement.text);
    });
    rmSelect.onDragLeave.listen((DropzoneEvent event) {
      event.dropzoneElement.style.margin = "1px";
    });
    rmSelect.onDragEnter.listen((DropzoneEvent event) {
      event.dropzoneElement.style.marginLeft = "25px";
    });
  }

  DimensionSelector DS = new DimensionSelector();
  Future<void> ngOnInit() async {
    DS.init();
  }

  bool isActive(String text) => DS.selectedStr.contains(text) || DS.selectedCol.contains(text);

}


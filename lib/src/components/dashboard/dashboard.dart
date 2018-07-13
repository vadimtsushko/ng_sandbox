import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'package:angular_forms/angular_forms.dart';
import 'dart:html';

import 'package:assortment/assortment.dart';
import 'package:dnd/dnd.dart';

//import 'tab.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard.html',
  styleUrls: ['dashboard.css'],
  directives: [coreDirectives,  routerDirectives, formDirectives],
)


class DashboardComponent implements OnInit {

//  Tab tab;
//  List<Tab> data = Data;

  String titleMeasurement = 'Показать измерения';


  List menuOption = ['Не выбрано', 'Дата', 'Неделя', 'Месяц', 'Квартал',
  'Год', 'День нед.', 'Классификатор товаров','Категория', 'Группа', 'Подгруппа',
  'ПодПодгруппа', 'Номенклатура' , 'Регион', 'Магазин', 'Менеджер', 'ТМ',
  'Поставщик', 'Поставщик, или группа поставщиков с одинаковым ИНН, или контрагент из бухгалтерии',
  'Страна происхождения товара', 'Тип товара', 'Опт/Розн', 'Вид номенклатуры',
  'Срок хранения', 'Супервайзер', 'Формат магазина', 'Матрица магазина',
  'Метка склада', 'Акция', 'Вид акции', 'Вся компания', 'Не выбрано', 'Магазин', 'Формат магазина', 'Регион', 'Адрес',
  'Менеджер', 'Категория', 'Группа', 'Подгруппа', 'ПодПодгруппа', 'ТМ',
  'Поставщик', 'Поставщик, или группа поставщиков с одинаковым ИНН, или контрагент из бухгалтерии',
  'Матрица магазина', 'Номенклатура', 'Код номенклатуры', 'Артикул',
  'Вид номенклатуры', 'Новинка', 'Срок хранения', 'Страна происхождения товара',
  'Единица измерения', 'Супервайзер', 'Опт/Розн'];
  
  List selectedStr = [];
  List selectedCol = [];

  DashboardComponent();


  void measurementToggle() {
    if(this.titleMeasurement == 'Показать измерения'){
      this.titleMeasurement = 'Скрыть измерения';
    } else {
      this.titleMeasurement = 'Показать измерения';
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
        this.selectedStr.add(elem.text);
      }
    } else {
      if(isActive){
        this.selectedCol.add(elem.text);
      }
    }

    new Timer(const Duration(milliseconds:20), () => this.dragEventsSelected() );

}

  void toggleRm(MouseEvent e) {

    HtmlElement elem = e.target;

    this.selectedStr.remove(elem.text);
    this.selectedCol.remove(elem.text);

    var element1 = document.querySelectorAll('.dndBtn');
    for(var i = 0; i < element1.length; i++){
      if(element1[i].text == elem.text) {
        element1[i].classes.remove('active');
      }
    }

  }

  var isDragEvents = false;
  dragEvents(){
    if(!this.isDragEvents){

      new Draggable(querySelectorAll('.dndBtn'),
          avatarHandler: new AvatarHandler.clone());

      Dropzone dropzoneStr = new Dropzone(querySelector('.strMeasurementBlock'));
      dropzoneStr.onDrop.listen((DropzoneEvent event) {
        this.toggleAction(event.draggableElement, false);
        this.rmDuplicate();
        this.rmDuplicateFromAnotherList('str');
      });
//      dropzoneStr.onDragLeave.listen((DropzoneEvent event) {
//        this.selectedStr.remove(event.draggableElement.text);
//      });


      Dropzone dropzoneCol = new Dropzone(querySelector('.colMeasurementBlock'));
      dropzoneCol.onDrop.listen((DropzoneEvent event) {
        this.toggleAction(event.draggableElement, true);
        this.rmDuplicate();
        this.rmDuplicateFromAnotherList('col');
      });

      this.isDragEvents = true;
    }
  }

  dragSelectedSort(dropzoneText, elementText){

    List newListS = [];
    for(int i = 0; i < this.selectedStr.length; i++) {
        if(this.selectedStr[i].toString() == dropzoneText.toString()) {
//          newListS.add(elementText);

        } else if (this.selectedStr[i].toString() == elementText.toString()){
          newListS.add(dropzoneText);
          newListS.add(elementText);
        } else {
          newListS.add(this.selectedStr[i]);
        }
    }
    this.selectedStr = newListS;

    List newListC = [];
    for(int i = 0; i < this.selectedCol.length; i++) {
      if(this.selectedCol[i].toString() == dropzoneText.toString()) {
//        newListC.add(elementText);
      } else if (this.selectedCol[i].toString() == elementText.toString()){
        newListC.add(dropzoneText);
        newListC.add(elementText);
      } else {
        newListC.add(this.selectedCol[i]);
      }
    }
    this.selectedCol = newListC;

  }

  rmDuplicateFromAnotherList(type){
    var activeList = type == 'col' ? this.selectedStr : this.selectedCol;
    var notActiveList = type != 'col' ? this.selectedStr : this.selectedCol;

    for(int i = 0; i < activeList.length; i++) {
      if(notActiveList.contains(activeList[i].toString())){
        activeList.remove(activeList[i].toString());
      }
    }
  }

  rmDuplicate(){

    List newListS = [];
    for(int i = 0; i < this.selectedStr.length; i++) {
      if(!newListS.contains(this.selectedStr[i].toString())){
        newListS.add(this.selectedStr[i]);
      }
    }
    this.selectedStr = newListS;

    List newListC = [];
    for(int i = 0; i < this.selectedCol.length; i++) {
      if(!newListC.contains(this.selectedCol[i].toString())){
        newListC.add(this.selectedCol[i]);
      }
    }
    this.selectedCol = newListC;

  }

  dragEventsSelected(){

    new Draggable(querySelectorAll('.rmSelect'), avatarHandler: new AvatarHandler.clone());
    Dropzone rmSelect = new Dropzone(querySelectorAll('.rmSelect'));
    rmSelect.onDrop.listen((DropzoneEvent event) {
      this.dragSelectedSort( event.draggableElement.text, event.dropzoneElement.text);
//      print(event.dropzoneElement.text);
    });
    rmSelect.onDragLeave.listen((DropzoneEvent event) {
      event.dropzoneElement.style.margin = "1px";
    });
    rmSelect.onDragEnter.listen((DropzoneEvent event) {
//      this.dragSelectedSort( event.draggableElement.text, event.dropzoneElement.text);
      print(event.dropzoneElement.text);
      event.dropzoneElement.style.marginLeft = "25px";
    });



  }



  Future<void> ngOnInit() async {}

}


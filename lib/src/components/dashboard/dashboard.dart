import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'dart:async';
import 'package:angular_forms/angular_forms.dart';
import 'dart:html';

//import 'hero.dart';
//import 'mock_heroes.dart';
import 'tab.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard.html',
  styleUrls: ['dashboard.css'],
  directives: [coreDirectives,  routerDirectives, formDirectives],
)


class DashboardComponent implements OnInit {

  Tab tab;
  List<Tab> data = Data;

  List menuOptionSelect = [];
  List menuOption = ['Классификатор товаров','Категория', 'Группа', 'Подгруппа',
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

  List menuTimeIntervalSelect = [];
  List menuTimeInterval = ['Не выбрано', 'Дата', 'Неделя', 'Месяц', 'Квартал',
  'Год', 'День нед.'];

  DashboardComponent();

  void toggle(MouseEvent e, type) {

    HtmlElement elem = e.target;
    elem.classes.toggle('active');

    if(type == 'date') {
      if(!this.menuTimeIntervalSelect.contains(elem.text)){
        this.menuTimeIntervalSelect.add(elem.text);
      } else {
        this.menuTimeIntervalSelect.remove(elem.text);
      }
    } else {
      if(!this.menuOptionSelect.contains(elem.text)){
        this.menuOptionSelect.add(elem.text);
      } else {
        this.menuOptionSelect.remove(elem.text);
      }
    }

  }

  void toggleRm(MouseEvent e, type) {

    HtmlElement elem = e.target;

    if(type == 'date') {
      this.menuTimeIntervalSelect.remove(elem.text);
    } else {
      this.menuOptionSelect.remove(elem.text);
    }

    var element1 = document.querySelectorAll('button');
    for(var i = 0; i < element1.length; i++){
      print(element1[i].text);
      if(element1[i].text == elem.text) {
//        print(element1[i].text);
        element1[i].classes.remove('active');
      }
    }



  }

  Future<void> ngOnInit() async {

  }

}
class DimensionSelector {
  List<dynamic> selectedStr = [];
  List<dynamic> selectedCol = [];
  List<dynamic> availableDims = [];

  dragSelectedSort(dropzoneText, elementText){
    List newListS = [];
    for(int i = 0; i < selectedStr.length; i++) {
      if(selectedStr[i].toString() == dropzoneText.toString()) {
//          newListS.add(elementText);
      } else if (selectedStr[i].toString() == elementText.toString()){
        newListS.add(dropzoneText);
        newListS.add(elementText);
      } else {
        newListS.add(selectedStr[i]);
      }
    }
    selectedStr = newListS;

    List newListC = [];
    for(int i = 0; i < selectedCol.length; i++) {
      if(selectedCol[i].toString() == dropzoneText.toString()) {
//        newListC.add(elementText);
      } else if (selectedCol[i].toString() == elementText.toString()){
        newListC.add(dropzoneText);
        newListC.add(elementText);
      } else {
        newListC.add(selectedCol[i]);
      }
    }
    selectedCol = newListC;
  }

  rmDuplicate(){
    List newListS = [];
    for(int i = 0; i < selectedStr.length; i++) {
      if(!newListS.contains(selectedStr[i].toString())){
        newListS.add(selectedStr[i]);
      }
    }
    selectedStr = newListS;

    List newListC = [];
    for(int i = 0; i < selectedCol.length; i++) {
      if(!newListC.contains(selectedCol[i].toString())){
        newListC.add(selectedCol[i]);
      }
    }
    selectedCol = newListC;
  }

  rmDuplicateFromAnotherList(type){
    var activeList = type == 'col' ? selectedStr : selectedCol;
    var notActiveList = type != 'col' ? selectedStr : selectedCol;

    for(int i = 0; i < activeList.length; i++) {
      if(notActiveList.contains(activeList[i].toString())){
        activeList.remove(activeList[i].toString());
      }
    }
  }

  init({List<dynamic> list = menuOption}) {
    availableDims = List.from(list);
  }

}


const menuOption = ['Не выбрано', 'Дата', 'Неделя', 'Месяц', 'Квартал',
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

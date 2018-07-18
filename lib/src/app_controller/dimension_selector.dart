class DimensionSelector {
  List<String> selectedStr = [];
  List<String> selectedCol = [];
  List<String> availableDims = [];

  sort(dropzoneText, elementText) {
    try {
      if (availableDims.contains(dropzoneText) &&
          availableDims.contains(elementText)) {
        List<String> newListS = [];
        for (int i = 0; i < selectedStr.length; i++) {
          if (selectedStr[i].toString() == dropzoneText.toString()) {
//          newListS.add(elementText);
          } else if (selectedStr[i].toString() == elementText.toString()) {
            newListS.add(dropzoneText);
            newListS.add(elementText);
          } else {
            newListS.add(selectedStr[i]);
          }
        }
        selectedStr = newListS;

        var newListC = <String>[];
        for (int i = 0; i < selectedCol.length; i++) {
          if (selectedCol[i].toString() == dropzoneText.toString()) {
//        newListC.add(elementText);
          } else if (selectedCol[i].toString() == elementText.toString()) {
            newListC.add(dropzoneText);
            newListC.add(elementText);
          } else {
            newListC.add(selectedCol[i]);
          }
        }
        selectedCol = newListC;
      } else {
        throw ("Error: ${dropzoneText} or ${elementText} not in availableDims");
      }
    } catch (e) {
      print(e);
    }
  }

  void moveTo(String to, String title) {
    try {
      if (availableDims.contains(title)) {
        if (to == 'str') {
          _addToStr(title);
          _rmFromCol(title);
        } else if (to == 'col') {
          _addToCol(title);
          _rmFromStr(title);
        } else {
          _rmFromCol(title);
          _rmFromStr(title);
        }
        _rmDuplicate();
      } else {
        throw ("Error: ${to} not in availableDims!");
      }
    } catch (e) {
      print(e);
    }
  }

  _addToCol(title) {
    selectedCol.add(title);
  }

  _rmFromCol(title) {
    selectedCol.remove(title);
  }

  _addToStr(title) {
    selectedStr.add(title);
  }

  _rmFromStr(title) {
    selectedStr.remove(title);
  }

  _rmDuplicate() {
    var newListS = <String>[];
    for (int i = 0; i < selectedStr.length; i++) {
      if (!newListS.contains(selectedStr[i].toString())) {
        newListS.add(selectedStr[i]);
      }
    }
    selectedStr = newListS;

    var newListC = <String>[];
    for (int i = 0; i < selectedCol.length; i++) {
      if (!newListC.contains(selectedCol[i].toString())) {
        newListC.add(selectedCol[i]);
      }
    }
    selectedCol = newListC;
  }

  init({List<String> list = testDims}) {
    availableDims = List.from(list);

  }
}

const testDims = [
  'Не выбрано',
  'Дата',
  'Неделя',
  'Месяц',
  'Квартал',
  'Год',
  'День нед.',
  'Классификатор товаров',
  'Категория',
  'Группа',
  'Подгруппа',
  'ПодПодгруппа',
  'Номенклатура',
  'Регион',
  'Магазин',
  'Менеджер',
  'ТМ',
  'Поставщик',
  'Поставщик, или группа поставщиков с одинаковым ИНН, или контрагент из бухгалтерии',
  'Страна происхождения товара',
  'Тип товара',
  'Опт/Розн',
  'Вид номенклатуры',
  'Срок хранения',
  'Супервайзер',
  'Формат магазина',
  'Матрица магазина',
  'Метка склада',
  'Акция',
  'Вид акции',
  'Вся компания',
  'Не выбрано',
  'Магазин',
  'Формат магазина',
  'Регион',
  'Адрес',
  'Менеджер',
  'Категория',
  'Группа',
  'Подгруппа',
  'ПодПодгруппа',
  'ТМ',
  'Поставщик',
  'Поставщик, или группа поставщиков с одинаковым ИНН, или контрагент из бухгалтерии',
  'Матрица магазина',
  'Номенклатура',
  'Код номенклатуры',
  'Артикул',
  'Вид номенклатуры',
  'Новинка',
  'Срок хранения',
  'Страна происхождения товара',
  'Единица измерения',
  'Супервайзер',
  'Опт/Розн'
];

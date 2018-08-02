part of 'filter_selector.dart';

const testMeasures = const [
  {
    "definition":
        "(-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Сумма)/1000 + Sum({<ТипПериода={'Current'}>} Компания))",
    "expandedDefinition":
        "(-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Сумма)/1000 + Sum({<ТипПериода={'Current'}>} Компания))",
    "name": "СуммаПродажиТыс",
    "filters": {},
    "family": "Продажи",
    "type": "Факт",
    "command": "set",
    "comment": "Сумма продаж в тыс. руб.",
    "label": "Продажи тыс.руб.",
    "selectorLabel": "Сумма продажи"
  },
  {
    "definition":
        "(\$(СуммаВП)/1000 + Sum({<ТипПериода={'Current'}>} Компания))",
    "expandedDefinition":
        "(((-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Сумма))-Money((-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Себестоимость)),'# ##0,0'))/1000 + Sum({<ТипПериода={'Current'}>} Компания))",
    "name": "СуммаВПТыс",
    "filters": {},
    "family": "ВП",
    "type": "Факт",
    "command": "set",
    "comment": "Наценка в тыс. руб.",
    "label": "Наценка тыс.руб.",
    "selectorLabel": "Наценка"
  },
  {
    "definition": "((\$(СуммаВП)/\$(УчСебестоимостьПолный)))",
    "expandedDefinition":
        "((((-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Сумма))-Money((-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Себестоимость)),'# ##0,0'))/Money((-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Себестоимость)),'# ##0,0')))",
    "name": "ПрцНаценки",
    "filters": {},
    "family": "ПроцентНаценка",
    "type": "Факт",
    "command": "set",
    "comment": "% Наценки",
    "label": "% Наценки",
    "selectorLabel": "% Наценки"
  },
  {
    "definition":
        "((Sum({<ТипДокумента={'OutOfStock'},ТипПериода={'Current'}>} Сумма*Себестоимость) -RangeMin(Sum({<ТипДокумента={'OutOfStock'},ТипПериода={'Current'}>} Сумма*Себестоимость), Sum({<ТипДокумента={'OutOfStock'},ТипПериода={'Current'}>} Количество*Себестоимость)))/1000)",
    "expandedDefinition":
        "((Sum({<ТипДокумента={'OutOfStock'},ТипПериода={'Current'}>} Сумма*Себестоимость) -RangeMin(Sum({<ТипДокумента={'OutOfStock'},ТипПериода={'Current'}>} Сумма*Себестоимость), Sum({<ТипДокумента={'OutOfStock'},ТипПериода={'Current'}>} Количество*Себестоимость)))/1000)",
    "name": "УпущеннаяВПТыс",
    "filters": {},
    "family": "УпущеннаяВП",
    "type": "Факт",
    "command": "set",
    "comment": "Упущенная ВП в тыс.руб.",
    "label": "Упущенная прибыль тыс. руб."
  },
  {
    "definition": "((1-\$(ТорговыеДни)/\$(ТорговыеДниРегламентные)))",
    "expandedDefinition":
        "((1-Money(Sum({<ТипДокумента={'OutOfStock'}, ТипПериода={'Current'}>} Количество),'# ##0')/Money(Sum({<ТипДокумента={'OutOfStock'}, ТипПериода={'Current'}>} Сумма),'# ##0')))",
    "name": "OutOfStock",
    "filters": {},
    "family": "OutOfStock",
    "type": "Факт",
    "command": "set",
    "comment": "Out Of Stock (отношение в днях)",
    "label": "%OOS",
    "selectorLabel": "% Out Of Stock"
  },
  {
    "definition":
        "Money((Sum({\$<ТипДокумента = {'OnHandSum'},\$(СбросФильтраПоОстаткам),ТипПериода={'Current'}>} Себестоимость)  / (\$(ПродажиСебестоимостьИзОстатков))),'# ##0,0')",
    "expandedDefinition":
        "Money((Sum({\$<ТипДокумента = {'OnHandSum'},ШкалаЛиквидности,ТипПериода={'Current'}>} Себестоимость)  / (Sum({\$<ТипДокумента = {'OnHandSum'},ШкалаЛиквидности,ТипПериода={'Current'}>} Сумма))),'# ##0,0')",
    "name": "Оборачиваемость",
    "filters": {},
    "family": "Оборачиваемость",
    "type": "Факт",
    "command": "set",
    "comment": "Оборачиваемость (считается только вплоть до месяцов), дни",
    "label": "Оборачиваемость, дни"
  },
  {
    "definition": "(\$(СуммаСписаний)/\$(СуммаПродажиТыс))",
    "expandedDefinition":
        "((-Sum({<ТипДокумента={'Spis'},ТипПериода={'Current'}>} Себестоимость)/1000 + Sum({<ТипПериода={'Current'}>} Компания))/(-Sum({<ТипДокумента={'Sales'},_ФлагДействующаяДата={1},ТипПериода={'Current'}>} Сумма)/1000 + Sum({<ТипПериода={'Current'}>} Компания)))",
    "name": "ПрСписания",
    "filters": {},
    "family": "ПроцентСписания",
    "type": "Факт",
    "command": "set",
    "label": "% Списания",
    "description":
        "Непонятно на что надо делить... (\$(СуммаСписаний)/RangeSum(\$(СуммаПродажиТыс),\$(ОстаткиТыс)))"
  },
  {
    "definition": "(\$(АктивныхSKU)/\$(УникальныхSKU))",
    "expandedDefinition":
        "((Sum({<ТипДокумента={'Sales'},ТипПериода={'Current'},_ФлагДействующаяДата={1},Сумма={'<0'}>} _НоменклатураСчетчик) + Sum({<ТипПериода={'Current'}>} Компания))/Sum({<ТипДокумента={'Sales'},ТипПериода={'Current'},Сумма={'<0'}>+<ТипДокумента={'OnHandEoM'},ТипПериода={'Current'},Количество={'<>0'}>} _НоменклатураСчетчик))",
    "name": "ДоляАктивныхSKU",
    "filters": {},
    "family": "ДоляАктивныхSKU",
    "type": "Факт",
    "command": "set",
    "format": "###0,00%",
    "label": "Доля Активных номенклатур"
  }
];
const testDimensions = const [
  {
    "id": "Склад",
    "labels": ["Склад"],
    "fields": ["Склад"],
    "copies": [],
    "title": "Склад",
    "grouping": "N",
    "width": 200
  },
  {
    "id": "Подгруппа",
    "labels": ["Подгруппа"],
    "fields": ["Подгруппа"],
    "copies": [],
    "title": "Подгруппа",
    "grouping": "N",
    "width": 200
  },
  {
    "id": "ПустоеЗначение",
    "labels": ["Не выбрано"],
    "fields": ["ПустоеЗначение"],
    "copies": [],
    "title": "Не выбрано",
    "grouping": "N",
    "width": 200
  },
  {
    "id": "Год",
    "labels": ["Год"],
    "fields": ["Год"],
    "copies": [],
    "title": "Год",
    "grouping": "N",
    "width": 120
  }
];
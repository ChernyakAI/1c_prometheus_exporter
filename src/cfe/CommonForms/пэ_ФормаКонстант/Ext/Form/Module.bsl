﻿// Copyright Copyright 2023 Andrei Chernyak
// Licensed under the Apache License, Version 2.0

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.РасписаниеРегламентногоЗадания.Доступность = НаборКонстант.пэ_ОтправлятьДанныеПоРасписанию;
	Задание = РегламентноеЗаданиеЭкспорта();
	Если Задание <> Неопределено Тогда
		РасписаниеРегламентногоЗадания = Задание.Расписание;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ОтправлятьДанныеПоРасписанию = НаборКонстант.пэ_ОтправлятьДанныеПоРасписанию;
	Задание = РегламентноеЗаданиеЭкспорта();
	
	Если Задание = Неопределено Тогда
		Если ОтправлятьДанныеПоРасписанию Тогда
			Задание = НовоеРегламентноеЗаданиеЭкспорта(ОтправлятьДанныеПоРасписанию, РасписаниеРегламентногоЗадания);
		КонецЕсли;
	Иначе
		Если ОтправлятьДанныеПоРасписанию И Модифицированность Тогда
			ПараметрыЗадания = Новый Структура("Расписание", РасписаниеРегламентногоЗадания);
			РегламентныеЗаданияСервер.ИзменитьЗадание(Задание.УникальныйИдентификатор, ПараметрыЗадания);
		КонецЕсли;
		Если Не ОтправлятьДанныеПоРасписанию Тогда
			ИдентификаторРегламентногоЗадания = Задание.УникальныйИдентификатор;
			РегламентныеЗаданияСервер.УдалитьЗадание(ИдентификаторРегламентногоЗадания);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура пэ_ОтправлятьДанныеПоРасписаниюПриИзменении(Элемент)
	
	ОтправлятьПоРасписанию = НаборКонстант.пэ_ОтправлятьДанныеПоРасписанию;
	Если ОтправлятьПоРасписанию Тогда
		РасписаниеРегламентногоЗадания = Новый РасписаниеРегламентногоЗадания;
		Элементы.РасписаниеРегламентногоЗадания.Доступность = Истина;
	Иначе
		Элементы.РасписаниеРегламентногоЗадания.Доступность = Ложь
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РасписаниеРегламентногоЗаданияНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Оповещение = Новый ОписаниеОповещения("НастроитьРасписаниеЭкспортаЗавершение", ЭтотОбъект);
	Диалог = Новый ДиалогРасписанияРегламентногоЗадания(РасписаниеРегламентногоЗадания);
	Диалог.Показать(Оповещение);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция НовоеРегламентноеЗаданиеЭкспорта(Знач Использование = Ложь, Знач Расписание)
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.пэ_ОтправкаДанныхВШлюзPrometheus);
	ПараметрыЗадания.Вставить("Использование", Использование);
	ПараметрыЗадания.Вставить("Расписание", Расписание);
	Возврат РегламентныеЗаданияСервер.ДобавитьЗадание(ПараметрыЗадания);
	
КонецФункции

&НаСервереБезКонтекста
Функция РегламентноеЗаданиеЭкспорта()
	
	Возврат пэ_Служебный.РегламентноеЗаданиеЭкспорта();
	
КонецФункции

&НаКлиенте
Процедура НастроитьРасписаниеЭкспортаЗавершение(Расписание, ДополнительныеПараметры) Экспорт
	
	Если Расписание <> Неопределено Тогда
		РасписаниеРегламентногоЗадания = Расписание;
		Модифицированность = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти



﻿// Экспортер метрик из базы данных системы 1С:Предприятие 8 в Prometheus
//
// Copyright 2023 Andrei Chernyak
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
// URL:    https://github.com/ChernyakAI/1c_prometheus_exporter
//

#Область ПрограммныйИнтерфейс

// Отправить метрики в prometheus pushgateway регламентным заданием
//
Процедура пэ_ОтправкаДанныхВШлюзPrometheus() Экспорт
	
	ОбщегоНазначения.ПриНачалеВыполненияРегламентногоЗадания(
		Метаданные.РегламентныеЗадания.пэ_ОтправкаДанныхВШлюзPrometheus
	);
	пэ_Метрики.ВыполнитьОтправкуМетрик();
	
КонецПроцедуры

// Возвращает регламентное задание базы, если оно было создано ранее
//
// Возвращаемое значение:
//  - Регламентное задание - найденное задание экспорта данных
//  - Неопределено - если задание в системе ранее не создавалось
//
Функция РегламентноеЗаданиеЭкспорта() Экспорт
	
	ПараметрыОтбора = Новый Структура("Метаданные", Метаданные.РегламентныеЗадания.пэ_ОтправкаДанныхВШлюзPrometheus);
	Задания = РегламентныеЗаданияСервер.НайтиЗадания(ПараметрыОтбора);
	Если Задания.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Задания[0];
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ИнтервалСбораВСекундах(ИнтервалСбора) Экспорт
	
	Если ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.Минута Тогда
		Возврат 60;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.ПятьМинут Тогда
		Возврат 60 * 5;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.ПятнадцатьМинут Тогда
		Возврат 60 * 15;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.ТридцатьМинут Тогда
		Возврат 60 * 30;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.Час Тогда
		Возврат 60 * 60;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.Сутки Тогда
		Возврат 60 * 60 * 24;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.Неделя Тогда
		Возврат 60 * 60 * 24 * 7;
	ИначеЕсли ИнтервалСбора = Перечисления.пэ_ИнтервалыСбораПоказателей.Месяц Тогда
		Возврат 60 * 60 * 24 * 30;
	Иначе
		Возврат 0;
	КонецЕсли;
	
КонецФункции

Функция ЭкранироватьСимволы(Знач СтрокаСимволов = "") Экспорт
	
	СтрокаСимволов = СтрЗаменить(СтрокаСимволов, """", "\""");
	Возврат СтрокаСимволов;
	
КонецФункции

#КонецОбласти



﻿// Copyright Copyright 2023 Andrei Chernyak
// Licensed under the Apache License, Version 2.0
//

&После("ПриОпределенииНастроекРегламентныхЗаданий")
Процедура пэ_ПриОпределенииНастроекРегламентныхЗаданий(Настройки)
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.пэ_ОтправкаДанныхВШлюзPrometheus;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	
КонецПроцедуры

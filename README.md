# Prometheus Exporter: экспорт данных из 1С в систему мониторинга Prometheus
Расширение, позволяющее выполнять отправку показателей [APDEX](https://its.1c.ru/db/metod8dev/content/5807/hdoc) в систему мониторинга [Prometheus](https://github.com/prometheus/prometheus).
Используется подсистема "Оценка производительности" библиотеки стандартных подсистем 1С.

## Требования
- Платформа **8.3.23** и выше.
- Библиотека стандартных подсистем (разрабатывалось на 3.1.6, но должно работать и на более ранних).

## Установка и первоначальная настройка
- Скопируйте файлы исходного кода из каталога src/cfe данного репозитория;
- Создайте в информационной базе новое расширение и загрузите файлы в него;
- При необходимости выполните адаптацию расширения (Конфигурация => Проверка возможности применения);
- В режиме 1С:Предприятие в появившемся разделе "Prometheus Exporter" определите профили, ключевые операции которых будут экспортироваться (справочник "Профили ключевых операций для экспорта). С помощью флага в справочнике можно включать/отключать отправку метрик по профилю;
- В том же разделе в настройках укажите имя задачи и имя инстанса. Также укажите период, за который будут собираться показатели из регистра замеров времени для расчёта APDEX. Если указано "Час", то за последний час на момент отправки.

## Варианты использования

##### 1. Предоставление сервиса для prometheus
- В режиме конфигуратора опубликуйте http-сервис из расширения (Администрирование => Публикация на веб-сервере);
- Убедитесь, что сервис отдаёт данные (../hs/metrics/get/);
- Настройте конфигурационный файл prometheus (пример настройки в файле prometheus/prometheus.yml).

##### 2. Экспорт регламентным заданием в настроенный шлюз Prometheus Pushgateway
Если предыдущий способ работы с Prometheus невозможен, то можно воспользоваться шлюзом [pushgateway](https://github.com/prometheus/pushgateway) для приёма данных:
- Установите в качестве службы и настройте prometheus pushgateway (пример настройки в файле prometheus/prometheus.yml)
- В режиме 1С:Предприятие в появившемся разделе "Prometheus Exporter" в настройках укажите адрес шлюза. Также включите отправку данных по расписанию, настройте его.

## Визуализация
Создайте новый дашборд в графане, можно воспользоваться следующими метриками с типом counter:
```
onec_apdex_value
onec_apdex_number_of_measurements
onec_apdex_average_duration_of_the_operation
onec_apdex_minimum_duration_of_the_operation
onec_apdex_maximum_duration_of_the_operation
```
В качестве заготовки можно импортировать небольшой пример из файла grafana/grafana.json

## Лицензии и права

- основная лицензия исходного кода продукта - Apache License, Version 2.0
- лицензии стороннего кода содержатся внутри файлов исходного кода

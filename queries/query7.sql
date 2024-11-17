SELECT
    *
FROM
    crosstab (
        $$SELECT "idВалюта1", "idВалюта2", "Значение курса"
   FROM mydb."Курс валюты"
   WHERE  "Дата" = '2024-04-20'
   order by 1,2$$,
        $$SELECT "idВалюта" FROM mydb."Валюта"$$
    ) AS ct (
        "idВалюта1" int,
        "0" numeric,
        "1" numeric,
        "2" numeric,
        "3" numeric
    )
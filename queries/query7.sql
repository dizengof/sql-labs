SELECT 
   *
FROM
    crosstab (
        $$SELECT "Название валюты", "idВалюта2", "Значение курса" FROM mydb."Валюта"
   LEFT JOIN (SELECT *
   FROM mydb."Курс валюты"
   WHERE "Дата" = CURRENT_DATE) AS t1
   ON "idВалюта" = "idВалюта1"$$,
        $$SELECT "idВалюта" FROM mydb."Валюта"$$
    ) AS ct (
        "Название валюты" text,
        "Криптодоллар" numeric,
        "Биткойн" numeric,
        "Эфириум" numeric
    )
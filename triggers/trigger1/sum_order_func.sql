CREATE OR REPLACE FUNCTION sum_order(order_id integer, cur_date date) RETURNS numeric AS $sum_order$
DECLARE
sum numeric;

BEGIN
SELECT
    SUM("Цена в валюте заказа") INTO sum
FROM
    (
        SELECT
            mydb."Список товаров в заказе"."id_Товар",
            "Текущая цена",
            mydb."Цена товара"."id_Валюта",
            mydb."Заказ"."Валюта заказа",
            ROUND("Текущая цена" * "Значение курса", 4) * mydb."Список товаров в заказе"."Количество"
                AS "Цена в валюте заказа"
        FROM
            mydb."Список товаров в заказе"
            JOIN mydb."Цена товара" ON mydb."Список товаров в заказе"."id_Товар" = mydb."Цена товара"."id_Предложения"
            JOIN mydb."Заказ" ON mydb."Список товаров в заказе"."id_Заказ" = mydb."Заказ"."id_Заказ"
            JOIN mydb."Курс валюты" ON mydb."Цена товара"."id_Валюта" = mydb."Курс валюты"."idВалюта1"
        WHERE
            mydb."Список товаров в заказе"."id_Заказ" = order_id -- id подаётся
            AND mydb."Цена товара"."Дата" = (
                SELECT
                    MAX(mydb."Цена товара"."Дата")
                FROM
                    mydb."Цена товара"
                WHERE
                    mydb."Список товаров в заказе"."id_Товар" = mydb."Цена товара"."id_Предложения"
            )
            AND mydb."Курс валюты"."idВалюта2" = mydb."Заказ"."Валюта заказа"
            AND mydb."Курс валюты"."Дата" = cur_date
    ) -- дата подаётся
;

RETURN sum;
END;
$sum_order$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION convert_price(order_id integer, order_currency integer) RETURNS numeric AS $convert_price$
DECLARE
sum_new_price numeric;

BEGIN

SELECT SUM(new_price) INTO sum_new_price FROM
(SELECT 
    ROUND(mydb."Документ об оплате"."Общая сумма" * "Значение курса", 4) AS new_price
FROM 
    mydb."Документ об оплате"
JOIN 
    mydb."Курс валюты" ON mydb."Документ об оплате"."id_Валюта" = mydb."Курс валюты"."idВалюта1"
WHERE 
    mydb."Курс валюты"."idВалюта2" = order_currency
AND mydb."Курс валюты"."Дата" = mydb."Документ об оплате"."Дата"
AND mydb."Документ об оплате"."id_Заказ" = order_id); 

RETURN sum_new_price;
END;
$convert_price$ LANGUAGE plpgsql;
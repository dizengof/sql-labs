CREATE OR REPLACE FUNCTION func1() RETURNS trigger AS $func1$
DECLARE
    order_status integer;
    order_currency integer;

BEGIN 
-- order_status := Код статуса заказа
SELECT
    mydb. "Заказ"."Код статуса заказа" INTO order_status
FROM
    mydb. "Заказ"
WHERE
    NEW."id_Заказ" = mydb. "Заказ"."id_Заказ";

-- order_currency := Валюта заказа
SELECT
    mydb. "Заказ"."Валюта заказа" INTO order_currency
FROM
    mydb. "Заказ"
WHERE
    NEW."id_Заказ" = mydb. "Заказ"."id_Заказ";

-- Если заказ оплачен, не даём создать запись
IF order_status = 3 THEN 
    RAISE EXCEPTION 'Заказ уже оплачен';
END IF;

IF convert_price(NEW.id_Заказ, order_currency) >= sum_order(NEW.id_Заказ, NEW.Дата)
THEN 
UPDATE 
    mydb."Заказ" SET "Код статуса заказа" = 3 
WHERE 
    NEW."id_Заказ" = mydb."Заказ"."id_Заказ";
END IF;

RETURN NEW;
END;
$func1$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tr1 AFTER
INSERT
    ON mydb."Документ об оплате" FOR EACH ROW EXECUTE PROCEDURE func1();
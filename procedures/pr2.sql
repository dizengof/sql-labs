CREATE
OR REPLACE PROCEDURE pr2 (order_num integer, addr text, is_last boolean) AS $pr2$

DECLARE

point_num integer;

BEGIN

IF (SELECT "Код статуса заказа" FROM mydb."Заказ" WHERE "id_Заказ" = order_num) = 5 THEN
    RAISE EXCEPTION 'Заказ уже доставлен';
END IF;

IF (SELECT "Код статуса заказа" FROM mydb."Заказ" WHERE "id_Заказ" = order_num) = 2 THEN
    RAISE EXCEPTION 'Заказ отменен';
END IF;

IF NOT EXISTS (SELECT "Код статуса заказа" FROM mydb."Заказ" WHERE "id_Заказ" = order_num) THEN
    RAISE EXCEPTION 'Заказа с таким номером не существует';
END IF;

IF NOT EXISTS (SELECT "id_Заказ" FROM mydb."Трекинг посылки" WHERE "id_Заказ" = order_num) THEN
    point_num := 0;
    UPDATE 
        mydb."Заказ"
    SET 
        "Код статуса заказа" = 4
    WHERE
        "id_Заказ" = order_num;
ELSE 
    SELECT
        COUNT(*) INTO point_num
    FROM
        mydb."Трекинг посылки"
    WHERE
        "id_Заказ" = order_num;
END IF;

INSERT INTO mydb."Трекинг посылки" (
        "id_Заказ",
        "Адрес",
        "Дата",
        "Последний пункт",
        "Номер пункта")
VALUES (
        order_num,
        addr,
        current_date,
        is_last,
        point_num);

IF is_last = true THEN
    UPDATE 
        mydb."Заказ"
    SET 
        "Код статуса заказа" = 5
    WHERE
        "id_Заказ" = order_num;
END IF;

END;
$pr2$ LANGUAGE plpgsql;
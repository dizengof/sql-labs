CREATE OR REPLACE PROCEDURE pr1 (blocked text) AS $pr1$
DECLARE

row record;

BEGIN

-- статус товаров будет переведен в скрытый
-- если продавец продаёт только запрещённые товары, то будет заблокирован
FOR row IN SELECT * FROM mydb."Предложение"
LOOP
    IF row."Артикул" IN (SELECT "Артикул" FROM mydb."Товар"
            WHERE "Краткое описание" ILIKE CONCAT('%', blocked, '%'))
    THEN 
        UPDATE mydb."Предложение" SET "Статус товара" = 3
        WHERE mydb."Предложение"."id_Предложения" = row."id_Предложения";

        IF NOT EXISTS (SELECT * FROM mydb."Предложение" 
                        WHERE "idПродавец" = row."idПродавец"
                        AND "Артикул" != row."Артикул")
        THEN 
            UPDATE mydb."Участник форума" SET "Статус" = 1
            WHERE mydb."Участник форума"."idУчастник" = row."idПродавец";
        END IF;
    END IF;
END LOOP;
-- из черновых заказов (0) товар будет удалён,
-- для ожидающих подтверждения (1) будет сформирован авто отказ (статус меняется на 2)
-- + новая запись в таблице 'Отказ'
FOR row IN SELECT * FROM mydb."Список товаров в заказе" JOIN mydb."Заказ" 
            ON mydb."Список товаров в заказе"."id_Заказ" = mydb."Заказ"."id_Заказ" 
LOOP
    IF row."id_Товар" IN (SELECT "id_Предложения" FROM mydb."Предложение" 
                        JOIN mydb."Товар" ON mydb."Предложение"."Артикул" = mydb."Товар"."Артикул"
                        WHERE "Краткое описание" ILIKE CONCAT('%', blocked, '%'))
    THEN
        IF row."Код статуса заказа" = 0
        THEN DELETE FROM mydb."Список товаров в заказе" 
                    WHERE mydb."Список товаров в заказе"."id_Заказ" = row."id_Заказ"
                    AND mydb."Список товаров в заказе"."id_Товар" = row."id_Товар";
        END IF;

        IF row."Код статуса заказа" = 1
        THEN UPDATE mydb."Заказ" SET "Код статуса заказа" = 2
             WHERE mydb."Заказ"."id_Заказ" = row."id_Заказ";

             INSERT INTO mydb."Отказ"("Номер заказа", "Причина отказа") 
             VALUES (row."id_Заказ", 'Запрещённый товар');
        END IF;
    END IF;
END LOOP;

END;
$pr1$ LANGUAGE plpgsql;
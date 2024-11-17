CREATE OR REPLACE FUNCTION func3() RETURNS trigger AS $func3$

BEGIN 

IF NOT EXISTS (
    SELECT * FROM mydb."Курс валюты"
    WHERE "Дата" = NEW."Дата"
    AND "idВалюта1" = NEW."idВалюта2"
    AND "idВалюта2" = NEW."idВалюта1"
)
THEN
INSERT INTO mydb."Курс валюты" ("idВалюта1", "idВалюта2", "Дата", "Значение курса")
VALUES (NEW."idВалюта2", NEW."idВалюта1", NEW."Дата",ROUND(1.05 * (1 / NEW."Значение курса"), 4));
END IF;

RETURN NEW;
END;
$func3$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tr3 AFTER
INSERT
    ON mydb."Курс валюты" FOR EACH ROW EXECUTE PROCEDURE func3 ();
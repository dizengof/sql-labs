-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS "mydb";

-- -----------------------------------------------------
-- Table "mydb"."Участник форума"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Участник форума" (
        "idУчастник" INT NOT NULL,
        "Никнейм" VARCHAR(20) NOT NULL,
        "Пароль" VARCHAR(45) NOT NULL,
        "Возраст" INT NOT NULL CHECK ("Возраст" > 18),
        "Номер счета" INT NOT NULL,
        "Статус" INT NOT NULL,
        PRIMARY KEY ("idУчастник")
    );

-- -----------------------------------------------------
-- Table "mydb"."Роль участника"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Роль участника" (
        "Код роли участника" INT NOT NULL CHECK (
            "Код роли участника" >= 0
            AND "Код роли участника" <= 3
        ),
        "Название роли" VARCHAR(45) NULL,
        PRIMARY KEY ("Код роли участника")
    );

-- -----------------------------------------------------
-- Table "mydb"."Участники_Роли"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Участники_Роли" (
        "idУчастник" INT NOT NULL,
        "Код роли участника" INT NOT NULL CHECK (
            "Код роли участника" >= 0
            AND "Код роли участника" <= 3
        ),
        PRIMARY KEY ("idУчастник", "Код роли участника"),
        CONSTRAINT "fk_Участники_Роли_1" FOREIGN KEY ("idУчастник") REFERENCES "mydb"."Участник форума" ("idУчастник") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Участники_Роли_2" FOREIGN KEY ("Код роли участника") REFERENCES "mydb"."Роль участника" ("Код роли участника") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Товар"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Товар" (
        "Артикул" INT NOT NULL,
        "Упаковка" VARCHAR(200) NOT NULL,
        "Краткое описание" VARCHAR(500) NOT NULL,
        PRIMARY KEY ("Артикул")
    );

-- -----------------------------------------------------
-- Table "mydb"."Предложение"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Предложение" (
        "id_Предложения" INT NOT NULL,
        "Артикул" INT NOT NULL,
        "idПродавец" INT NOT NULL,
        "Доступное количество" INT NOT NULL CHECK ("Доступное количество" >= 0),
        "Статус товара" INT NOT NULL,
        PRIMARY KEY ("id_Предложения"),
        CONSTRAINT "fk_Товар_1" FOREIGN KEY ("idПродавец") REFERENCES "mydb"."Участник форума" ("idУчастник") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Предложение_1" FOREIGN KEY ("Артикул") REFERENCES "mydb"."Товар" ("Артикул") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Валюта"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Валюта" (
        "idВалюта" INT NOT NULL,
        "Название валюты" VARCHAR(45) NOT NULL,
        "Описание валюты" VARCHAR(500) NULL,
        PRIMARY KEY ("idВалюта")
    );

-- -----------------------------------------------------
-- Table "mydb"."Цена товара"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Цена товара" (
        "id_Цена_товара" INT NOT NULL,
        "id_Предложения" INT NOT NULL,
        "id_Валюта" INT NOT NULL,
        "Дата" DATE NOT NULL,
        -- timestamp
        "Текущая цена" NUMERIC NOT NULL,
        PRIMARY KEY ("id_Цена_товара"),
        CONSTRAINT "fk_Цена товара_1" FOREIGN KEY ("id_Предложения") REFERENCES "mydb"."Предложение" ("id_Предложения") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Цена товара_2" FOREIGN KEY ("id_Валюта") REFERENCES "mydb"."Валюта" ("idВалюта") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Статусы заказов"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Статусы заказов" (
        "Код статуса заказа" INT NOT NULL CHECK (
            "Код статуса заказа" >= 0
            AND "Код статуса заказа" <= 5
        ),
        "Статус заказа" VARCHAR(45) NOT NULL,
        PRIMARY KEY ("Код статуса заказа")
    );

-- -----------------------------------------------------
-- Table "mydb"."Заказ"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Заказ" (
        "id_Заказ" INT NOT NULL,
        "idПокупатель" INT NOT NULL,
        "Валюта заказа" INT NOT NULL,
        "Код статуса заказа" INT NOT NULL,
        PRIMARY KEY ("id_Заказ"),
        CONSTRAINT "fk_Заказ_1" FOREIGN KEY ("idПокупатель") REFERENCES "mydb"."Участник форума" ("idУчастник") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Заказ_2" FOREIGN KEY ("Валюта заказа") REFERENCES "mydb"."Валюта" ("idВалюта") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Заказ_3" FOREIGN KEY ("Код статуса заказа") REFERENCES "mydb"."Статусы заказов" ("Код статуса заказа") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Документ об оплате"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Документ об оплате" (
        "idДокумент об оплате" INT NOT NULL,
        "id_Заказ" INT NOT NULL,
        "id_Валюта" INT NOT NULL,
        "Общая сумма" NUMERIC NOT NULL,
        "Дата" DATE NOT NULL,
        "Ответственный модератор" INT NOT NULL,
        PRIMARY KEY ("idДокумент об оплате"),
        CONSTRAINT "fk_Документ об оплате_1" FOREIGN KEY ("id_Заказ") REFERENCES "mydb"."Заказ" ("id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Документ об оплате_2" FOREIGN KEY ("Ответственный модератор") REFERENCES "mydb"."Участник форума" ("idУчастник") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Документ об оплате_3" FOREIGN KEY ("id_Валюта") REFERENCES "mydb"."Валюта" ("idВалюта") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Отказ"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Отказ" (
        "idОтказ" SERIAL NOT NULL,
        "Номер заказа" INT NOT NULL,
        "Причина отказа" VARCHAR(500) NOT NULL,
        PRIMARY KEY ("idОтказ"),
        CONSTRAINT "fk_Отказ_1" FOREIGN KEY ("Номер заказа") REFERENCES "mydb"."Заказ" ("id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Курс валюты"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Курс валюты" (
        "idВалюта1" INT NOT NULL,
        "idВалюта2" INT NOT NULL,
        "Дата" DATE NOT NULL,
        "Значение курса" NUMERIC NOT NULL,
        PRIMARY KEY ("idВалюта1", "idВалюта2", "Дата"),
        CONSTRAINT "fk_Курс валюты_1" FOREIGN KEY ("idВалюта1") REFERENCES "mydb"."Валюта" ("idВалюта") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Курс валюты_2" FOREIGN KEY ("idВалюта2") REFERENCES "mydb"."Валюта" ("idВалюта") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Трекинг посылки"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Трекинг посылки" (
        "Трек-номер" INT NOT NULL,
        "Адрес" VARCHAR(45) NOT NULL,
        "Дата" DATE NOT NULL,
        "Номер пункта" INT NOT NULL,
        PRIMARY KEY ("Трек-номер")
    );

-- -----------------------------------------------------
-- Table "mydb"."Список товаров в заказе"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Список товаров в заказе" (
        "id_Заказ" INT NOT NULL,
        "id_Товар" INT NOT NULL,
        "Количество" INT NOT NULL,
        PRIMARY KEY ("id_Заказ", "id_Товар"),
        CONSTRAINT "fk_Список товаров в заказе_1" FOREIGN KEY ("id_Заказ") REFERENCES "mydb"."Заказ" ("id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Список товаров в заказе_2" FOREIGN KEY ("id_Товар") REFERENCES "mydb"."Предложение" ("id_Предложения") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Отзыв о товаре"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Отзыв о товаре" (
        "idОтзыв о товаре" INT NOT NULL,
        "id_Товар" INT NOT NULL,
        "id_Заказ" INT NOT NULL,
        "Оценка" INT NOT NULL CHECK (
            "Оценка" >= 1
            AND "Оценка" <= 5
        ),
        "Комментарий" VARCHAR(45) NULL,
        "Дата" DATE NOT NULL,
        "Ответ" VARCHAR(45) NULL,
        "Дата ответа" DATE NULL,
        PRIMARY KEY ("idОтзыв о товаре"),
        CONSTRAINT "fk_Отзыв о товаре_1" FOREIGN KEY ("id_Товар", "id_Заказ") REFERENCES "mydb"."Список товаров в заказе" ("id_Товар", "id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Список отказов"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Список отказов" (
        "id_Списка_отказов" INT NOT NULL,
        "idОтказ" INT NOT NULL,
        "id_Товар" INT NOT NULL,
        "id_Заказ" INT NOT NULL,
        PRIMARY KEY ("id_Списка_отказов"),
        CONSTRAINT "fk_Список отказов_1" FOREIGN KEY ("idОтказ") REFERENCES "mydb"."Отказ" ("idОтказ") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Список отказов_2" FOREIGN KEY ("id_Товар", "id_Заказ") REFERENCES "mydb"."Список товаров в заказе" ("id_Товар", "id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Список оплаченных товаров"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Список оплаченных товаров" (
        "id_Списка_оплаты" INT NOT NULL,
        "idДокумент об оплате" INT NULL,
        "id_Товар" INT NULL,
        "id_Заказ" INT NULL,
        PRIMARY KEY ("id_Списка_оплаты"),
        CONSTRAINT "fk_Список оплаченных товаров_1" FOREIGN KEY ("idДокумент об оплате") REFERENCES "mydb"."Документ об оплате" ("idДокумент об оплате") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Список оплаченных товаров_2" FOREIGN KEY ("id_Товар", "id_Заказ") REFERENCES "mydb"."Список товаров в заказе" ("id_Товар", "id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table "mydb"."Треки_заказы"
-- -----------------------------------------------------
CREATE TABLE
    IF NOT EXISTS "mydb"."Треки_заказы" (
        "Трек-номер" INT NOT NULL,
        "id_Заказ" INT NULL,
        PRIMARY KEY ("Трек-номер"),
        CONSTRAINT "fk_Треки_заказы_1" FOREIGN KEY ("id_Заказ") REFERENCES "mydb"."Заказ" ("id_Заказ") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "fk_Треки_заказы_2" FOREIGN KEY ("Трек-номер") REFERENCES "mydb"."Трекинг посылки" ("Трек-номер") ON DELETE NO ACTION ON UPDATE NO ACTION
    );
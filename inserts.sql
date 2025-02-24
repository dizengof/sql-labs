-- -----------------------------------------------------
-- Table "mydb"."Участник форума"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Участник форума" (
        "idУчастник",
        "Никнейм",
        "Пароль",
        "Возраст",
        "Номер счета",
        "Статус" -- 0 ok, 1 block
    )
VALUES
    (0, 'alice', '12345', 43, 000001, 0), -- польз.
    (1, 'bob', 'qwerty', 65, 003456, 0), -- польз.
    (2, 'corey', '@w3s%8+', 27, 002345, 0), -- админ.
    (3, 'diane', '99Aa999', 19, 004567, 0), -- модер.
    (4, 'ethan', 'password', 34, 001010, 0), -- польз.
    (5, 'fiona', '{hell]l09', 35, 000233, 0), -- модер.
    (6, 'george', 'tre453', 21, 003434, 0);

-- польз.
-- -----------------------------------------------------
-- Table "mydb"."Роль участника"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Роль участника" ("Код роли участника", "Название роли")
VALUES
    (0, 'Администратор'),
    (1, 'Модератор'),
    (2, 'Пользователь');

-- -----------------------------------------------------
-- Table "mydb"."Участники_Роли"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Участники_Роли" ("idУчастник", "Код роли участника")
VALUES
    (0, 2),
    (1, 2),
    (2, 0),
    (3, 1),
    (4, 2),
    (5, 1),
    (6, 2);

-- -----------------------------------------------------
-- Table "mydb"."Товар"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Товар" ("Артикул", "Упаковка", "Краткое описание")
VALUES
    (10, 'a', 'Гитара Yamaha'),
    (20, 'b', 'Кружка с картинкой'),
    (30, 'v', 'Фигурка супергероя'),
    (40, 'c', 'Учебник по физике'),
    (50, 'd', 'Куртка Columbia'),
    (60, 'e', 'DVD сериала Друзья'),
    (70, 'f', 'Пачка сигарет Marlboro'),
    (80, 'g', 'Приставка PlayStation 5'),
    (90, 'h', 'Кресло-качалка');

-- -----------------------------------------------------
-- Table "mydb"."Предложение"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Предложение" (
        "id_Предложения",
        "Артикул",
        "idПродавец",
        "Доступное количество",
        "Статус товара" -- 0 черновой, 1 выставлен, 2 снят, 3 скрыт
    )
VALUES
    (0, 10, 0, 2, 1), -- alice продаёт 2 гитары
    (1, 70, 0, 1, 0), -- сигареты у alice в черновом предложении
    (2, 10, 1, 1, 1), -- bob продаёт 1 гитару...
    (3, 20, 1, 5, 1), -- и 5 кружек
    (4, 30, 1, 4, 2), -- а также продал 2 фигурки
    (5, 30, 2, 3, 1), -- corey продаёт 3 фигурки... 
    (6, 40, 2, 2, 1), -- 2 учебника...
    (7, 50, 2, 1, 1), -- и куртку
    (8, 60, 3, 10, 1), -- diane продаёт 10 dvd
    (9, 80, 3, 1, 1), -- и одну приставку
    (10, 70, 4, 5, 1), -- ethan продаёт 5 пачек сигарет
    (11, 90, 5, 3, 1), -- fiona продаёт 3 кресла
    (12, 90, 6, 2, 1);

-- george продаёт 2 кресла
-- -----------------------------------------------------
-- Table "mydb"."Валюта"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Валюта" ("idВалюта", "Название валюты", "Описание валюты")
VALUES
    (0, 'Криптодоллар', 'Аналог доллара'),
    (1, 'Биткойн', NULL),
    (2, 'Эфириум', NULL);

-- -----------------------------------------------------
-- Table "mydb"."Цена товара"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Цена товара" (
        "id_Цена_товара",
        "id_Предложения",
        "id_Валюта",
        "Дата",
        "Текущая цена"
    )
VALUES
    (0, 0, 0, '2024-09-28', 199.99),
    (1, 0, 0, '2024-09-30', 189.99),
    (2, 0, 0, '2024-10-02', 150.00),
    (3, 1, 1, '2024-10-02', 0.04),
    (4, 1, 1, '2024-09-30', 0.05),
    (5, 2, 2, '2024-09-28', 0.01233),
    (6, 3, 0, '2024-04-20', 20.50),
    (7, 4, 0, '2023-05-05', 40.0),
    (8, 4, 0, '2024-06-20', 20.0),
    (9, 5, 2, '2023-05-05', 0.04),
    (10, 6, 1, '2023-05-05', 0.01),
    (11, 7, 1, '2024-01-21', 0.15),
    (12, 8, 1, '2024-02-21', 1.0),
    (13, 9, 2, '2022-02-21', 123.2),
    (14, 10, 0, '2024-04-20', 120.00),
    (15, 11, 0, '2024-11-16', 100.00),
    (16, 12, 2, '2024-11-16', 50.00);

-- -----------------------------------------------------
-- Table "mydb"."Статусы заказов"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Статусы заказов" ("Код статуса заказа", "Статус заказа")
VALUES
    (0, 'Черновой'),
    (1, 'Ожидает подтверждение'),
    (2, 'Отказан'),
    (3, 'Оплачен'),
    (4, 'Отправлен'),
    (5, 'Выполнен');

-- -----------------------------------------------------
-- Table "mydb"."Заказ"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Заказ" (
        "id_Заказ",
        "idПокупатель",
        "Валюта заказа",
        "Код статуса заказа"
    )
VALUES
    (0, 1, 0, 5), -- покупатель bob, выполнен
    (1, 0, 1, 2), -- alice, отказан
    (2, 2, 2, 4), -- corey, отправлен
    (3, 3, 0, 1), -- diane
    (4, 3, 1, 1), -- diane
    (5, 4, 0, 1), -- ethan
    (6, 5, 2, 1), -- fiona
    (7, 6, 0, 1), -- george
    (8, 2, 1, 1), -- corey
    (9, 5, 2, 1),
    (10, 1, 0, 0);

-- черновой заказ на сигареты
-- -----------------------------------------------------
-- Table "mydb"."Документ об оплате"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Документ об оплате" (
        "idДокумент об оплате",
        "id_Заказ",
        "id_Валюта",
        "Общая сумма",
        "Дата",
        "Ответственный модератор"
    )
VALUES
    (0, 0, 0, 100.50, '2024-10-20', 3);

-- -----------------------------------------------------
-- Table "mydb"."Отказ"
-- -----------------------------------------------------
-- INSERT INTO
--     "mydb"."Отказ" ("idОтказ", "Номер заказа", "Причина отказа")
-- VALUES
--     (0, 0, 'не подошло');
-- -----------------------------------------------------
-- Table "mydb"."Курс валюты"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Курс валюты" (
        "idВалюта1",
        "idВалюта2",
        "Дата",
        "Значение курса"
    )
VALUES
    (0, 0, '2023-01-01', 1),
    (1, 0, '2023-01-01', 50000),
    (0, 1, '2023-01-01', 0.5),
    (2, 0, '2023-01-01', 10000),
    (0, 0, '2024-09-28', 1),
    (1, 0, '2024-09-28', 10000),
    (0, 1, '2024-09-28', 0.1),
    (2, 0, '2024-09-28', 20000),
    (0, 0, '2024-09-30', 1),
    (1, 0, '2024-09-30', 10000),
    (2, 0, '2024-09-30', 20000),
    (0, 0, '2024-10-02', 1),
    (1, 0, '2024-10-02', 10000),
    (2, 0, '2024-10-02', 20000),
    (0, 0, '2024-04-20', 1),
    (1, 1, '2024-04-20', 1),
    (2, 2, '2024-04-20', 1),
    (1, 0, '2024-04-20', 10000),
    (0, 1, '2024-04-20', 0.0001),
    (2, 0, '2024-04-20', 20000);

-- -----------------------------------------------------
-- Table "mydb"."Трекинг посылки"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Трекинг посылки" (
        "id_Заказ",
        "Адрес",
        "Дата",
        "Последний пункт",
        "Номер пункта"
    )
VALUES
    (0, 'Москва', '2024-11-05', false, 0),
    (0, 'СПб', '2024-11-10', false, 1),
    (0, 'Выборг', '2024-11-12', true, 2),
    (2, 'Москва', '2024-11-11', false, 0),
    (2, 'Красногорск', '2024-11-13', false, 1);

-- -----------------------------------------------------
-- Table "mydb"."Список товаров в заказе"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Список товаров в заказе" ("id_Заказ", "id_Товар", "Количество")
VALUES
    (0, 0, 1),
    (1, 3, 3),
    (1, 5, 1),
    (2, 9, 2),
    (3, 10, 4), -- сигареты не в черновом
    (3, 11, 1),
    (4, 2, 1),
    (5, 11, 1),
    (5, 12, 2),
    (6, 3, 1),
    (7, 8, 3),
    (8, 10, 2), -- сигареты не в черновом
    (9, 0, 1),
    (10, 10, 1),
    (10, 5, 2);

-- сигареты и фигурки в черновом
-- -----------------------------------------------------
-- Table "mydb"."Отзыв о товаре"
-- -----------------------------------------------------
INSERT INTO
    "mydb"."Отзыв о товаре" (
        "idОтзыв о товаре",
        "id_Товар",
        "id_Заказ",
        "Оценка",
        "Комментарий",
        "Дата",
        "Ответ",
        "Дата ответа"
    )
VALUES
    (
        0,
        0,
        0,
        5,
        'ok',
        '2024-11-30',
        'sps',
        '2024-12-01'
    ),
    (1, 3, 1, 4, NULL, '2024-11-11', NULL, NULL),
    (2, 5, 1, 1, NULL, '2024-11-12', NULL, NULL),
    (3, 9, 2, 5, NULL, '2024-11-13', NULL, NULL),
    (4, 10, 3, 3, NULL, '2024-11-14', NULL, NULL),
    (5, 11, 3, 4, NULL, '2024-11-15', NULL, NULL),
    (6, 2, 4, 2, NULL, '2024-11-16', NULL, NULL),
    (7, 11, 5, 4, NULL, '2024-11-17', NULL, NULL),
    (8, 12, 5, 5, NULL, '2024-11-18', NULL, NULL),
    (9, 3, 6, 2, NULL, '2024-11-19', NULL, NULL),
    (10, 8, 7, 2, NULL, '2024-11-20', NULL, NULL),
    (11, 10, 8, 4, NULL, '2024-11-21', NULL, NULL),
    (12, 0, 9, 3, NULL, '2024-11-22', NULL, NULL),
    (13, 10, 10, 4, NULL, '2024-11-23', NULL, NULL),
    (14, 5, 10, 2, NULL, '2024-11-24', NULL, NULL);

-- -----------------------------------------------------
-- Table "mydb"."Список отказов"
-- -----------------------------------------------------
-- INSERT INTO
--     "mydb"."Список отказов" (
--         "id_Списка_отказов",
--         "idОтказ",
--         "id_Товар",
--         "id_Заказ"
--     )
-- VALUES
--     (NULL, NULL, NULL, NULL);
-- -----------------------------------------------------
-- Table "mydb"."Список оплаченных товаров"
-- -----------------------------------------------------
-- INSERT INTO
--     "mydb"."Список оплаченных товаров" (
--         "id_Списка_оплаты",
--         "idДокумент об оплате",
--         "id_Товар",
--         "id_Заказ"
--     )
-- VALUES
--     (NULL, NULL, NULL, NULL);
-- -----------------------------------------------------
-- Table "mydb"."Треки_заказы"
-- -----------------------------------------------------
-- INSERT INTO
--     "mydb"."Треки_заказы" ("Трек-номер", "id_Заказ")
-- VALUES
--     (0000, 0),
--     (0001, 2);
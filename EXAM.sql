DROP DATABASE IF EXISTS book_shop;
CREATE DATABASE book_shop;
USE book_shop;

CREATE TABLE country(
	country_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL UNIQUE CHECK(name <> '')
);

INSERT country
VALUES
(1,'Беларусь'),
(2,'Россия'),
(3,'США'),
(4,'Канада'),
(5,'Польша');
SELECT * FROM country;


CREATE TABLE autor(
	autor_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name NVARCHAR(64) NOT NULL CHECK(''),
    surname NVARCHAR(64) NOT NULL CHECK(''),
    country_ID INT NOT NULL,
    CONSTRAINT fk_autor_to_country FOREIGN KEY (country_ID) REFERENCES country (country_ID)
);

INSERT autor
VALUES
(1,'Мартин','Грабер',3),
(2,'Джошуа','Блох',3),
(3,'Дмитрий ','Жемеров',2),
(4,'Антти ','Лааксонен',4),
(5,'Вячеслав','Черников',2);
SELECT * FROM autor;

CREATE TABLE theme(
	theme_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE CHECK('') 
);
INSERT theme
VALUES
(1,'SQL'),
(2,'Java'),
(3,'Cotlin'),
(4,'Programming'),
(5,'C#');
SELECT * FROM theme;

CREATE TABLE book(
	book_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name NVARCHAR(64) NOT NULL CHECK(name <> ''),
    page INT NOT NULL CHECK(page >= 0),
    prise DECIMAL(15, 2) NOT NULL CHECK(prise > 0.00),
    publish_date DATE NOT NULL CHECK(publish_date <= NOW()),
    autor_ID INT NOT NULL,
    theme_ID INT NOT NULL,
    CONSTRAINT fk_book_to_theme FOREIGN KEY(theme_ID) REFERENCES theme (theme_ID),
    CONSTRAINT fk_book_to_autor FOREIGN KEY(autor_ID) REFERENCES autor (autor_ID)
);

INSERT book
VALUES
(1,'SQL для простых смертных', 672, 27.36, '2009-01-01',1 , 1),
(2,'Java. Эффективное программирование', 590, 29.85,'2013-01-01', 2, 2),
(3,'Kotlin в действии', 501, 44.80, '2017-01-01',3 , 3),
(4,'Олимпиадное программирование',300,39.82,'2018-01-01', 4, 4),
(5,'Разработка мобильных приложений на C# и Java для iOS и Android',188,39.82,'2019-01-01', 5, 5);
SELECT * FROM book;

CREATE TABLE shop(
	shop_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name NVARCHAR(64) NOT NULL CHECK(''),
    country_ID INT NOT NULL,
    CONSTRAINT fk_shop_to_country FOREIGN KEY (country_ID) REFERENCES country (country_ID)

);
INSERT shop 
VALUES
(1,'OZ',1),
(2,'Первый книжный',2),
(3,'book shop',3);
SELECT * FROM shop;


CREATE TABLE sale(
	sale_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    prise DECIMAL(15, 2) NOT NULL CHECK(prise > 0.00),
    quantity INT NOT NULL CHECK(quantity > 0),
    sale_date DATE NOT NULL CHECK(sale_date <= NOW()),
    book_ID INT NOT NULL,
    shop_ID INT NOT NULL,
    CONSTRAINT fk_sale_to_book FOREIGN KEY (book_ID) REFERENCES book (book_ID),
    CONSTRAINT fk_sale_to_shop FOREIGN KEY (shop_ID) REFERENCES shop (shop_ID)
);

INSERT sale
VALUES
(1,21.50,20,'2010-02-04',1,1),
(2,25.43,10,'2014-10-07',2,3),
(3,30.30,40,'2019-04-10',5,2);
SELECT * FROM sale;

-- Task01
SELECT * FROM book
WHERE page > 500 AND page < 650;

-- Task02
SELECT * FROM book
WHERE name LIKE 'K%' OR 'S%';

-- Task03
SELECT * FROM book 
JOIN theme ON theme.theme_ID = book.theme_ID
JOIN sale ON sale.book_ID = book.book_ID
WHERE theme.name = 'SQL' AND sale.quantity > 10;

-- task04
SELECT * FROM book
WHERE name LIKE 'Java%' AND name NOT LIKE 'Android%';

-- Task05
SELECT CONCAT(book.name, theme.name, autor.name), book.prise, book.page
FROM book, theme, autor
WHERE book.theme_ID = theme.theme_ID AND
book.autor_ID = autor.autor_ID AND
 book.prise / book.page < 0.08; 
 
 -- Task06
 SELECT *
 FROM book
 WHERE name LIKE '% % % %';
 
 -- Task07
 SELECT book.name, theme.name, autor.name, book.prise, sale.quantity, shop.name
 FROM book, theme, autor, sale, shop
 WHERE shop.shop_ID = sale.shop_ID AND
 book.book_ID = sale.book_ID AND
 theme.theme_ID = book.theme_ID AND
 autor.autor_ID = book.autor_ID AND
 country.country_ID = shop.country_ID;
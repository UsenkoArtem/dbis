/*---------------------------------------------------------------------------
1.�������� ����� ����� � ������ � ������� ��������, � ��� ���������� ����: 
������ ������ � ������� �� ��������� �����
4 ����

---------------------------------------------------------------------------*/
--��� �������:
Create user artem IDENTIFIED by usenko
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

GRANT CONNECT to artem;
GRANT SELECT any TABLE to artem;
GRANT DROP any TABLE to artem;

/*---------------------------------------------------------------------------
2. �������� �������, � ���� ��������� ���� �� ����. ������ �� ������ ����� 
���������� ������ �� ������� �������������� ������� ALTER TABLE. 
���������� ����������� �� ��� C++
4 ����

---------------------------------------------------------------------------*/
--��� �������:

CREATE TABLE Programist
(
  programist_id VARCHAR(5) not null,
  programist_name VARCHAR(40) not null
);

CREATE TABLE Language
(
language_id varchar(5) not null,
language_name VARCHAR(40) not null
);

CREATE TABLE Programist_Language 
(
programist_language_id varchar(5) not null,
programist_id VARCHAR(5) not null,
language_id varchar(5) not null
);

Alter TABLE Programist ADD CONSTRAINT programist_pk PRIMARY KEY (programist_id);
Alter TABLE Language ADD CONSTRAINT language_pk PRIMARY KEY (language_id);
ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_pk PRIMARY KEY (programist_language_id);
ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_fk FOREIGN KEY (programist_id) REFERENCES Programist(programist_id);
ALTER TABLE Programist_Language ADD CONSTRAINT programist_language_fk FOREIGN KEY (language_id) REFERENCES Language(language_id);
  
/* --------------------------------------------------------------------------- 
3. ������ �������� ����� ������������ (���������� � ����� � 1) ��� ��������� �������, 
�������� ����� � ������� �� ��������� ������ �������������� ������� ALTER/GRANT. 
����������� ���� ����� �������������� ��� � ���� OracleScript �� �������� ������: 

---------------------------------------------------------------------------*/
--��� �������:

GRANT CREATE any TABLE to artem;
GRANT SELECT any TABLE to artem;
GRANT INSERT any TABLE to artem;
GRANT ALTER any TABLe to artem;

/*---------------------------------------------------------------------------
3.a. 
���� ����� ���������� ���� ������� ����������� �����?
�������� �������� � ������ �����. 
4 ����
---------------------------------------------------------------------------*/

--��� �������:
SELECT 
    OrderItems.order_num  
      FROM OrderItems 
          WHERE OrderItems.item_price = 
              (SELECT MAX(OrderItems.item_price ) FROM OrderItems);

/*---------------------------------------------------------------------------
3.b. 
��������� ������ ��������� ���� ��������� - �������� �� ���� name.
�������� �������� � SQL. 
4 ����

---------------------------------------------------------------------------*/

--��� �������:

SELECT
   COUNT(DISTINCT TRIM(vend_name)) as name
FROM VENDORS;


/*---------------------------------------------------------------------------
c. 
������� ����� ������������� � �������� ������,�������� �� ���� vendor_name, �� ����� ����� � ���� �������.
�������� �������� � ������ �����. 
4 ����

---------------------------------------------------------------------------*/
--��� �������:
SELECT
  (LOWER (Vendors.vend_name)) as vendor_name
  FROM Vendors 
  WHERE Vendors.vend_id  IN
  (SELECT 
     DISTINCT Products.vend_id    
    FROM Products
      Where  Products.prod_id IN 
      (
        SELECT 
          DISTINCT OrderItems.prod_id
         FROM OrderItems
      )
  );

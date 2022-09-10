create database ecommerce;
use ecommerce;

-- login do cliente
create table LoginClients(
idLoginClient int auto_increment primary key,
userName varchar(45) not null unique,
passwords char(10) not null,
lastLogin timestamp
);


INSERT INTO LoginClients
values 
	(1,'maxximogr','maxx1234','2022-09-04 19:54'),
    (2,'tatibg','tatibg1234','2022-09-04 19:55'),
	(3,'pedrogb','pedro199','2022-01-03 12:54'),
	(4,'claudiosv','csv1010','2022-08-10 21:00'),
	(5,'barbaratp','btp1996','2022-09-04 20:54'),
	(6,'atacadao01','atac10','2022-09-04 19:54'),
    (7,'cdasmarcas','cdm1990','2022-09-04 19:55'),
	(8,'ricardoeletro','reletro01','2022-01-03 12:54'),
	(9,'plarecia','larecia20','2022-08-10 21:00'),
	(10,'torresu10','torresu09','2022-09-04 20:54');
	


-- clientesCNPJ
create table ClientsCNPJ(
idClientCNPJ int auto_increment primary key,
idLClientCNPJ int not null,
companyName varchar(45) not null,
CNPJ char(14) not null,
tradingName varchar(45) not null,
address varchar(255) not null,
contact char(11),
email varchar(50) not null,
constraint unique_client_cnpj unique(CNPJ),
constraint fk_clientcnpj_login foreign key(idLClientCNPJ) references LoginClients(idLoginClient)
);

INSERT INTO ClientsCNPJ
values (1,1,'João G. Cardoso',12345678912, 'Atacadão','Rua das Marcas, 100, São Paulo', 112111119,'atacadao@gmail.com'),
	   (2,2,'Tereza M. Silva',12345678911, 'Casa das Marcas', 'Avenida das Americas, 10, Rio de Janeiro', 211111119,'casadasmarcas@hotmail.com'),
       (3,3,'Ricardo A. Barros',12345666666, 'Ricardo Eletro', 'Rua Uruguaiana, 20, Rio de Janeiro', 213333337,'ricardoeletro@gmail.com'),
	   (4,4,'Pedro S. Peixoto',123456789555, 'Peixoto Lar&Cia', 'Rua Uruguaiana, 40, Rio de Janeiro', 213333388,'peixotolarecia@gmail.com'),
	   (5,5,'Carlos P. Torres',12345644444, 'Torres Utilidades', 'Rua São Cristovão, 20, Rio de Janeiro', 213333338,'torres@gmail.com');
        
        
	
-- clientesCPF
create table ClientsCPF(
idClientCPF int auto_increment primary key,
idLClientCPF int not null,
Fname varchar(10) not null,
Minit varchar(5) not null,
Lname varchar(20) not null,
CPF char(11) not null,
Bdate date not null,
address varchar(255) not null,
contact char(11),
email varchar(50) not null,
constraint unique_client_cpf unique(CPF),
constraint fk_clientcpf_login foreign key(idLClientCPF) references LoginClients(idLoginClient)
);


INSERT INTO ClientsCPF
values (1,1,'Maximo','G','Rodrigues',11334543212,'1985-08-01','Rua Rodolfo, 186, Rio de Janeiro',213456781,'maxximogr@hotmail.com'),
       (2,2,'Tatiane','B','Guimarães',11334543234,'1985-05-14','Rua Rodolfo, 186, Rio de Janeiro',213456551,'tatianebg@gmail.com'),
       (3,3,'Pedro','G','Barros',11234567789,'1990-08-21','Avenida Beira Rio, 500, Curitiba',213444781,'pedrogb@hotmail.com'),
       (4,4,'Claudio','S','Vieira',12323456789,'1976-01-10','Rua Silveira, 5, Manaus',213444211,'claudiosv@gmail.com'),
       (5,4,'Barbara','T','Pereira',11334545555,'1996-10-01','Travessa, 86, Fortaleza',213456111,'btpereira@gmail.com');

	   
       



-- pedido
create table Orders(
idOrder int auto_increment primary key,
idOloginclient int,
orderStatus enum('Canceled','Confirmed','Processing') default 'Processing',
orderDescription varchar(255),
shippingValue float default 10,
shippingDate date not null,
trackingCode char(15) not null,
constraint fk_order_loginclient foreign key(idOloginclient) references LoginClients(idLoginClient)
);


INSERT INTO Orders
Values
	(default,1,'Confirmed','1x Tênis Nike',10,'2022-09-20','BR2116291948882'),
	(default,2,Default,'2x Camisa Adidas',20,'2022-09-20','BR2116291948883'),
	(default,3,'Confirmed','1x Geladeira Eletrolux',10,'2022-09-22','BR2116291948884'),
	(default,4,'Canceled','1x Boneca Barbie Sereia',10,'2022-09-21','BR2116291948885'),
	(default,5,'Confirmed','1x Televisão Samsung 50',10,'2022-09-19','BR2116291948886'),
    (default,6,'Confirmed','5x Tênis Adidas',50,'2022-09-15','BR2116291948887'),
	(default,7,Default,'10x Camisa Adidas',100,'2022-09-17','BR2116291948888'),
	(default,8,'Confirmed','5x Televisão LG 55',500,'2022-09-19','BR2116291948889'),
	(default,9,'Canceled','15x Jogo de Panelas Tramontina ',150,'2022-09-11','BR2116291948811'),
	(default,10,'Confirmed','6x Geladeira Consul 345l',60,'2022-09-13','BR2116291948810');




-- FRETE
create table Shipping(
idSloginClient int,
idSorder int,
shippingStatus enum('In transport','Delivered','Lost'),
constraint fk_shipping_loginclient foreign key(idSloginClient) references LoginClients(idLoginClient),
constraint fk_shipping_order foreign key(idSorder) references Orders(idOrder)
);

INSERT INTO Shipping
values
		(1, default,'In transport'),
		(2,default,'Delivered'),
		(3,default,'Lost'),
		(4,default,'Delivered'),
		(5,default,'In Transport'),
        (6, default,'In transport'),
		(7,default,'Delivered'),
		(8,default,'Lost'),
		(9,default,'Delivered'),
		(10,default,'In Transport');


-- relação pedido/produto
create table ProductsOrders(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum('Available','Unavailable'),
primary key(idPOproduct, idPoOrder),
constraint fk_product_product foreign key(idPOproduct) references Products(idProduct),
constraint fk_product_order foreign key(idPOorder) references Orders(idOrder)
);

INSERT INTO ProductsOrders
Values
	(1,1,10,'Available'),
	(2,2,20,'Available'),
	(3,3,10,'Available'),
	(4,4,0,'Unavailable'),
	(5,5,16,'Available'),
	(6,6,10,'Available'),
	(7,7,20,'Available'),
	(8,8,10,'Available'),
	(9,9,15,'Available'),
	(10,10,16,'Available');





-- produtos
create table Products(
idProduct int auto_increment primary key,
Pname varchar(45) not null,
descreption varchar(255) not null,
classification_kids boolean default false,
category enum('Electronic','Clothes','Toys','Utilities','Foods') not null,
dimension varchar(10),
rating float default 0
);

INSERT INTO Products
values
	(1,'Tênis Nike','Nº43, Branco com preto',False,'Clothes','Nº43','5'),
	(2,'Camisa Adidas','Preta',False,'Clothes','G','5'),
	(3,'Geladeira Eletrolux FROSTFREE','Branca, 345L',False,'Electronic','60x60x1,90','5'),
	(4,'Boneca Barbie Sereia','Coleção Barbie',True,'Toys','40cm','5'),
	(5,'Televisão Samsung 50','4K, 2x usb, 3x HDMI, Tela infinita',False,'Electronic','55x110x05','5'),
    (6,'Tênis Adidas','Nº39, Branco com preto',False,'Clothes','Nª39','5'),
	(7,'Camisa Adidas','Branca',False,'Clothes','M','5'),
	(8,'Televisão LG 55','4K, LED',False,'Electronic','55x120x05','5'),
	(9,'Jogo de Panela Tarmontina','Brava, Inox',False,'Utilities','60x50x50','5'),
	(10,'Geladeira Consul FROSTFREE','Inox, 380l',False,'Electronic','60x60x200','5');




-- relação produto/vendendor
create table ProductSeller(
idPseller int,
idPproduct int,
quantity int default 1,
primary key(idPseller, idPproduct),
constraint fk_product_seller foreign key(idPseller) references Seller(idSeller),
constraint fk_products_product foreign key(idPproduct) references Products(idProduct)
);






-- vendedor
create table Seller(
idSeller int auto_increment primary key,
companyName varchar(45),
CNPJ char(14) not null,
CPF char(11) not null,
tradingName varchar(45),
address varchar(255),
contact char(11) not null,
constraint unique_seller_cnpj unique(CNPJ),
constraint unique_seller_cpf unique(CPF)
);

INSERT INTO Seller
Values
	(1,'AERIS DE EQUIP. G. ENERGIA S/A',12528708000107,11421345673,'Luz Forte S/A','Avenida das Nações, 1001, Rio de Janeiro',21987654321),
	(2,'AREZZO INDÚSTRIA E COMÉRCIO S.A.',16590234000176,11232178643,'AREZZO','Rua dos Oliveiras, 10, São Paulo',11234234234),
	(3,'BCO BTG PACTUAL S.A.',30306294000145,11695123432,'BTG PACTUAL','Avenida Treze de Maio, 508, Brasília',61987623451),
	(4,'BARDELLA S.A. INDUSTRIAS MECANICAS',60851615000153,11123434321,'BARDELLA','Rua Benedito, 34, Manaus',92900854321),
	(5,'BK BRASIL O. A. A RESTAURANTES SA',13574594000196,11131234321,'BK BRASIL S/A','Avenida Atlântica, 100, Rio de Janeiro',21987687612);


-- estoque
create table Inventory(
idInventory int auto_increment primary key,
inventoryLocation varchar(255),
quantity int default 0
);

INSERT INTO Inventory
values
	(1,'Rio de Janeiro',32),
	(2,'São Paulo',44),
	(3,'Brasília',100),
	(4,'Pará',40),
	(5,'Curitiba',60);


-- relação produto/estoque
create table ProductsInventory(
idPinventory int,
idIproduct int,
quantity int default 1,
primary key(idPinventory, idIproduct),
constraint fk_product_inventory foreign key(idPinventory) references Products(idProduct),
constraint fk_inventory_product foreign key(idIproduct) references Inventory(idInventory)
);


INSERT INTO ProductsInventory
Values
	(1,1,25),
    (2,2,10),
    (3,3,60),
    (4,4,80),
    (5,5,default);




-- fornecedor
create table Supplier(
idSupplier int auto_increment primary key,
companyName varchar(60) not null,
CNPJ CHAR(14) not null,
trading varchar(20) not null,
address varchar(255) not null,
contact char(11)
);


INSERT INTO Supplier
VALUES
	(1,'AREZZO INDÚSTRIA E COMÉRCIO S.A.',16590234000176,'AREZZO','Rua dos Oliveiras, 10, São Paulo',11234234234),
    (2,'WESTWING COMERCIO VAREJISTA S.A.',14776142000150,'WEST','Avenida Nossa Senhora de Copacabana, 90, Rio de Janeiro',21998987654),
    (3,'LG ELECTRONICS DO BRASIL LTDA',01166372000236,'LG','Avenida Doutor Chucri Zaidan, 940, SAO PAULO', 1121625400),
    (4,'CIA. HERING',78876950015950,'HERING','RUA JOSE PAULINO, BOM RETIRO, SÃO PAULO',4733213544),
    (5,'MANUFATURA DE BRINQUEDOS ESTRELA S A',61082004000150,'ESTRELA S A','AVENIDA EUSEBIO MATOSO, 1375,SÃO PAULO',1121027031);



-- relação produto/fornecedor
create table productsSupplier(
idPOsupplier int,
idPOproduct int,
quantity int default 0,
primary key(idPOsupplier, idPOproduct),
constraint fk_product_supplier foreign key (idPOsupplier) references Supplier(idSupplier),
constraint fk_supplier_product foreign key(idPOproduct) references Products(idProduct)
);

INSERT INTO productsSupplier
VALUES
	(1,1,2000),
    (2,2,1700),
    (3,3,500),
    (4,4,2500),
    (5,5,1000);






-- formas de pagamento
create table Payments(
idPayment int auto_increment primary key,
idPayOrder int,
idPayproduct int,
typePayment enum('Cash','CreditCard','Ticket') default 'CreditCard',
totalPrice decimal(5,2) not null,
paymentStatus enum('Authorized','Not Authorized','Processing','Chargeback') default 'Processing',
constraint fk_pay_order foreign key(idPayOrder) references Orders(idOrder),
constraint fk_pay_product foreign key(idPayproduct) references Products(idProduct)
);

INSERT INTO Payments
VALUES
	(1,1,1,'CreditCard',269.00,'Authorized'),
    (2,2,2,'Cash',250.00,'Authorized'),
    (3,3,3,'CreditCard',645.00,'Not Authorized'),
    (4,4,4,'Ticket',659.00,'Chargeback'),
    (5,5,5,'CreditCard',890.90,'Authorized'),
    (6,6,6,'CreditCard',269.00,'Authorized'),
    (7,7,7,'Cash',250.00,'Authorized'),
    (8,8,8,'CreditCard',645.00,'Not Authorized'),
    (9,9,9,'Ticket',659.00,'Processing'),
    (10,10,10,'CreditCard',890.90,'Authorized');





-- pagamento com cartão de crédito
create table CreditCard(
idCredicard int auto_increment primary key,
idPayCredCard int,
credCardFlag varchar(20) not null,
cardNumber char(16) not null,
expirationDate date not null,
cardHolderName varchar(45) not null,
securityCode char(3) not null,
constraint fk_pay_creditcard foreign key(idPayCredCard) references Payments(idPayment)
);

INSERT INTO CreditCard
VALUES
	(1,1,'MasterCard',5454334567654321,'2023-09-15','SEBASTIAO V SOUZA',656),
    (2,2,'Visa',4245565434567898,'2022-12-01','CARLOS T VENANCIO',989),
    (3,3,'America Express',3798123498675456,'24-08-01','MARCELA A RIBEIRO',102),
    (4,4,'ELO',6754123432567897,'23-02-01','CASSIO G COSTA',234),
    (5,5,'MasterCard',5498987676545654,'2023-01-20','ROBERTO P RODRIGUES',432);



-- pagamento com boleto
create table Ticket(
idTicket int auto_increment primary key,
idPayTicket int,
bankName varchar(20) not null,
barCode char(47) not null,
dueDate date not null,
constraint fk_pay_ticket foreign key(idPayTicket) references Payments(idPayment)
);

INSERT INTO Ticket
VALUES
	(1,1,'BRADESCO',00190500954014481606906809350314337370000000100,'2022-09-08'),
    (2,2,'ITAU',00190500954014481606906809350314337370000000200,'2022-10-01'),
    (3,3,'SANTANDER',00123500954014481606906809350314337370000000100,'2022-09-15'),
    (4,4,'ITAU',00190500954014481606906809350314337370000000300,'2022-11-01'),
    (5,5,'BRADESCO',00190500954014481606906809350314337370000000400,'2022-09-20');
    
    

-- pagamento com dinheiro/Pix
create table Cash(
idCash int auto_increment primary key,
idPayCash int,
pix enum('Pix CPF','Pix email','Pix cellphone','Pix random'),
constraint fk_pay_cash foreign key(idPayCash) references Payments(idPayment)
);

INSERT INTO Cash
VALUES
	(1,1,'PIX CPF'),
    (2,2,'PIX email'),
    (3,3,'PIX CPF'),
    (4,4,'PIX email'),
    (5,5,'PIX CPF');
    




-- QUERIES
select * from Orders o, ProductsOrders p where o.idOrder = idPOorder;

SELECT Fname AS nome, Lname AS sobrenome, email AS email, address as endereço, idClientcpf as n_cliente FROM clientscpf order by lname;


select * from LoginClients l, Orders o where l.idLoginClient = idOloginClient;

select concat(Fname,' ',Lname) as Client, idOrder, orderStatus from ClientsCPF c, Orders o where idClientCPF = idOLoginClient;

select * from Orders o, Payments p where o.idOrder = idPayOrder;
    
Select * from LoginClients inner join Orders on IdLoginClient = idOloginClient;
							
select * from LoginClients l inner join Orders o on l.idLoginClient = o.idOloginClient
							 inner join productsOrders p on p.idPOorder = o.idOrder;
					
                    
select CNPJ, companyName from Seller;

select * from seller s, products p where s.idseller = idproduct;

select * from payments p, Creditcard c where p.idPayment= idpayCredcard;


    
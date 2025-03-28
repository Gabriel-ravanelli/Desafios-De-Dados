-- criação do banco de dados para o cenario de e-commerce
create database ecommerce;
use ecommerce;

drop table produtctseller;
-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
		fName varchar(10),
        Minit char(3),
        Lname varchar(20),
        Cpf char(11) not null,
        Address varchar(30),
        constraint unique_cpf_client unique (Cpf)

);

-- criar tabela produto
create table Product(
		idProduct int auto_increment primary key,
		PName varchar(10),
        classification_kids bool default false,
        category enum('eletronico','vestimenta','brinquedos')not null,
        avaliaçao float default 0,
        size varchar(10)
        

);
-- cria tabela pagamentos
create table payments(
	idcliente int,
    idpayment int,
    typepayment enum('boleto','cartao'),
    limitAvailable float,
	primary key(idCliente, idpayment)


);



-- cria tabela pedido
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('cancelado','confimado','em processamento') default 'em processamento',
        orderdescription varchar (255),
        sendvalue float default 10,
        paymentcash bool default false,
        constraint fk_orders_cliente foreign key (idOrderClient) references clients(idClient)


);

-- cria tabela estoque

create table storage(
		idstorage int auto_increment primary key,
        storagelocation int,
        quantity int default 0 
	
);

-- cria tabela fornecedor
create table supplier(
		idsupplier int auto_increment primary key,
        socialname varchar(255) not null,
        cnpj char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique(cnpj)
	
);
-- cria tabela vendedor

create table seller(
		idseller int auto_increment primary key,
        socialname varchar(255) not null,
        abstname varchar(255),
        cpf char (9),
        cnpj char(15),
        location varchar(255),
        contact char(11) not null ,
        constraint unique_cnpj_seller unique(cnpj),
        constraint unique_cpf_seller unique(cpf)
	
);


create table productseller(
		idpseller int,
        idproduct int,
		prodquantity int default 1,
		primary key (idpseller,idproduct),
        constraint fk_product_seller foreign key (idpseller) references seller(idseller),
		constraint fk_product_Product foreign key (idProduct) references product(idProduct)
);

create table produtctorder(
		idpoproduct int,
        idpoOrder int,
		poquantity int default 1,
        postatus enum('disponivel', 'sem estoque') default 'disponivel',
		primary key (idpoproduct,idpoOrder),
        constraint fk_productorder_seller foreign key (idpoproduct) references product(idproduct),
		constraint fk_productorder_product foreign key (idpoOrder) references orders(idOrder)
);

create table storagelocattion(
		idlproduct int,
        idlstorage int,
		location varchar(255) not null,
		primary key (idlproduct,idlstorage),
        constraint fk_storagelocation_seller foreign key (idlproduct) references product(idproduct),
		constraint fk_storageproduct_product foreign key (idlstorage) references storage(idstorage)
);

create table productsupplier(
		idpsupplier int,
        idpsproduct int,
		quantity int not null,
		primary key (idpsupplier,idpsproduct),
        constraint fk_idpsproduct_seller foreign key (idpsproduct) references product(idproduct),
		constraint fk_idpsupplier_product foreign key (idpsupplier) references supplier(idsupplier)
);

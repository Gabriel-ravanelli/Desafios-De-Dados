

use ecommerce;

INSERT INTO clients (fName, Minit, Lname, Cpf, Address) VALUES
('Carlos', 'A', 'Silva', '12345678901', 'Rua das Flores, 123'),
('Ana', 'B', 'Santos', '98765432100', 'Av. Paulista, 456'),
('Mariana', 'C', 'Ferreira', '45612378902', 'Rua das Palmeiras, 789');

INSERT INTO Product (PName, classification_kids, category, avaliaçao, size) VALUES
('Celular', false, 'eletronico', 4.5, 'Médio'),
('Camiseta', false, 'vestimenta', 4.0, 'G'),
('Boneca', true, 'brinquedos', 5.0, 'Pequeno');

INSERT INTO payments (idcliente, idpayment, typepayment, limitAvailable) VALUES
(1, 101, 'cartao', 2000.50),
(2, 102, 'boleto', 500.00),
(3, 103, 'cartao', 1500.75);

INSERT INTO orders (idOrderClient, orderStatus, orderdescription, sendvalue, paymentcash) VALUES
(1, 'confimado', 'Pedido de um celular', 15.00, false),
(2, 'em processamento', 'Pedido de uma camiseta', 10.00, true),
(3, 'cancelado', 'Pedido de uma boneca', 12.50, false);

INSERT INTO storage (idstorage, storagelocation, quantity) VALUES
(101, 101, 50),
(102, 102, 100),
(103, 103, 30);


INSERT INTO supplier (socialname, cnpj, contact) VALUES
('Fornecedor A', '123456789012345', '11999999999'),
('Fornecedor B', '987654321098765', '11888888888'),
('Fornecedor C', '456123789012345', '11777777777');

INSERT INTO seller (socialname, abstname, cpf, cnpj, location, contact) VALUES
('Vendedor X', 'X Store', '123456789', '123123123123123', 'Centro, SP', '11955555555'),
('Vendedor Y', 'Y Roupas', '987654321', '987987987987987', 'Zona Sul, RJ', '11844444444'),
('Vendedor Z', 'Z Brinquedos', '456123789', '456456456456456', 'Centro, MG', '11733333333');

INSERT INTO productseller (idpseller, idproduct, prodquantity) VALUES
(1, 1, 10),
(2, 2, 20),
(3, 3, 15);

INSERT INTO produtctorder (idpoproduct, idpoOrder, poquantity, postatus) VALUES
(1, 1, 1, 'disponivel'),
(2, 2, 2, 'disponivel'),
(3, 3, 1, 'sem estoque');

INSERT INTO storagelocattion (idlproduct, idlstorage, location) VALUES
(1, 101, 'Bloco A - Prateleira 3'),
(2, 102, 'Bloco B - Prateleira 2'),
(3, 103, 'Bloco C - Prateleira 1');

INSERT INTO productsupplier (idpsupplier, idpsproduct, quantity) VALUES
(1, 1, 100),
(2, 2, 200),
(3, 3, 150);



select  * from productseller;

select count(*) from clients;
select * from clients c, orders o where	c.idClient = idOrderClient;

select fName lName, idOrder, orderStatus from clients c,orders o where c.idClient =idOrderClient;

insert into orders (idOrderClient, orderStatus, orderdescription, sendvalue, paymentcash) values
					(2, default,'compra via aplicativo',null,1);

select count(*) from clients c, orders o
			where c.idClient = idOrderClient;
            
            
select * from produtctorder;
select * from clients c inner join orders o on c.idClient = o.idOrderClient;


-- quantos pedidos foram realizado pelo cliente?
select c.idClient, fName, count(*) as number_of_orders from clients c 
					inner join orders o on c.idClient = o.idOrderClient
					group by idClient
                    HAVING COUNT(*) > 2;
                    
-- Algum vendedor também é fornecedor?

-- explicação da querie  JOIN supplier sup ON s.cpf = sup.cnpj OR s.cnpj = sup.cnpj;
-- Verifica se o CPF do vendedor (seller.cpf) é igual ao CNPJ do fornecedor (supplier.cnpj).
-- Também verifica se o CNPJ do vendedor (seller.cnpj) é igual ao CNPJ do fornecedor (supplier.cnpj).
-- Retorna apenas os vendedores que também são fornecedores.

SELECT s.idseller, s.socialname AS vendedor, sup.idsupplier, sup.socialname AS fornecedor
FROM seller s
JOIN supplier sup 
ON s.cpf = sup.cnpj OR s.cnpj = sup.cnpj;

-- Relação de produtos fornecedores e estoques;
SELECT 
    p.idProduct, 
    p.PName AS produto, 
    s.idsupplier, 
    s.socialname AS fornecedor, 
    st.idstorage, 
    sl.location AS local_estoque, 
    ps.quantity AS quantidade_fornecida, 
    st.quantity AS quantidade_estoque
FROM product p
JOIN productsupplier ps ON p.idProduct = ps.idpsproduct
JOIN supplier s ON ps.idpsupplier = s.idsupplier
JOIN storagelocattion sl ON p.idProduct = sl.idlproduct
JOIN storage st ON sl.idlstorage = st.idstorage;

-- Relação de nomes dos fornecedores e nomes dos produtos;

SELECT 
    s.socialname AS fornecedor, 
    p.PName AS produto
FROM supplier s
JOIN productsupplier ps ON s.idsupplier = ps.idpsupplier
JOIN product p ON ps.idpsproduct = p.idProduct;



create database oficina;
use oficina;


-- tabela tratado (profissionais)
create table tratado (
    idtratado int auto_increment primary key,
    nome varchar(45) not null,
    endereco varchar(45),
    especialidade varchar(45)
);

-- tabela cliente
create table cliente (
    idcliente int auto_increment primary key,
    nome varchar(45) not null,
    sobrenome varchar(45),
    cpf char(11) unique,
    placa_carro varchar(10),
    telefone varchar(15)
);

-- tabela ordem_servico
create table ordem_servico (
    idordem int auto_increment primary key,
    idcliente int not null,
    idtratado int not null,
    data_servico date not null,
    status varchar(20) default 'aberto',
    observacoes text,
    foreign key(idcliente) references cliente(idcliente),
    foreign key(idtratado) references tratado(idtratado)
);

-- tabela servico (genérica para concerto e revisao)
create table servico (
    idservico int auto_increment primary key,
    idordem int not null,
    tipo enum('concerto', 'revisao') not null,
    preco decimal(10,2) not null,
    data_conclusao date,
    endereco_execucao varchar(45),
    descricao text,
    foreign key(idordem) references ordem_servico(idordem)
);

select * FROM tratado
-- criação do bancos de dados para o cenário de E-commerce
create database ecommerces;
use ecommerces;

-- criar tabela cliente
create table clients(
          idClient int auto_increment primary key,
          Fname varchar(10),
          Minit char(3),
          Lname varchar(20),
          CPF char(11) not null,
          Address varchar(30),
          constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment = 1;
desc clients;
-- criar tabela veiculo
-- size = dimensão do produto

create table vehicle(
          idVehicle int auto_increment primary key,
          Pname varchar(25) not null,
          size varchar(10)
);

create table payments(
          idClient int,
          idPayment int,
          typePayment enum('Boleto','Cartão de crédito','Cartão de débito'),
		  limitAvailable float,
          primary key (idClient, id_payment)
);


-- criar tabela Os

create table os(
          idOs int auto_increment primary key,
          idOsClient int,
          osStatus enum('Concertado','Em processamento') default 'Em processamento',
          osDate date,
          osDateconclusão date,
		  sendValue float default 10,
          paymentCash bool default false,
          constraint fk_os_client foreign key (idOsClient) references clients(idClient)
);
desc Os;

-- criar tabela Garagem
create table garage(
          idGarage int auto_increment primary key,
          garage varchar(255),
          quantityVehicle int default 0
);

-- criar tabela mecânico
create table mechanical(
          idMechanical int auto_increment primary key,
          SocialName varchar(255) not null,
          contact char(11) not null,
          specialty varchar(25) not null,
          Address varchar(30)
);
desc mechanical;

create table serviceExecution(
          idPOs int,
          idPMechanical int,
          primary key (idPOs, idPMechanical),
          constraint fk_serviceexecution_os foreign key (idPOs) references os(idOs),
          constraint fk_serviceexecution_mechanical foreign key (idPMechanical) references mechanical(idMechanical)
);
desc serviceexecution;

create table customerApproval(
          idCAclient int,
          idCAos int,
          approval bool default false,
          poStatus enum('Aprovado', 'Não aprovado') default 'Não aprovado',
          primary key (idCAclient, idCAos),
          constraint fk_customerApproval_client foreign key (idCAclient) references clients(idClient),
          constraint fk_customerApproval_os foreign key (idCAOs) references os(idOs)
);

desc customerApproval;
show tables;
show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerces';

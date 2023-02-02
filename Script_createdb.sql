create schema practica authorization sajesrgs;

create table practica.coche(
	id_coche varchar(10) not null, --PK
	matricula varchar(200) not null,
	km_totales integer not null, 
	fecha_compra date not null,
	color varchar(200) not null,
	id_modelo varchar(10) not null,  --FK
	id_poliza varchar(10),  --FK
	constraint coche_PK primary key(id_coche)
);

-- Creando las tables relacionadas con modelo, marca y grupo

create table practica.grupo_coche(
	id_grupo varchar(10) not null, --PK
	nombre varchar(200) not null,
	constraint grupo_coche_PK primary key(id_grupo)
);

create table practica.marca(
	id_marca varchar(10) not null, --PK
	nombre varchar(200) not null,
	id_grupo varchar(10) not null, --FK
	constraint marca_PK primary key(id_marca)
);

alter table practica.marca 
add constraint marca_grupo_FK foreign key (id_grupo)
references practica.grupo_coche(id_grupo);

create table practica.modelo(
	id_modelo varchar(10) not null, --PK
	nombre varchar(200) not null,
	id_marca varchar(10) not null, --FK
	constraint modelo_PK primary key(id_modelo)
);

alter table practica.modelo
add constraint modelo_marca_FK foreign key (id_marca)
references practica.marca(id_marca);

--AÑADIDA FOREIGN KEY IDMODELO A TABLE COCHE

alter table practica.coche  
add constraint coche_modelo_FK foreign key (id_modelo)
references practica.modelo(id_modelo);

-- CREANDO TABLES DE ASEGURADORA Y POLIZA

create table practica.aseguradora(
	id_aseguradora varchar(10) not null, --PK
	nombre varchar(200) not null,
	constraint aseguradora_PK primary key(id_aseguradora)
);

create table practica.poliza(
	id_poliza varchar(10) not null, --PK
	numero_poliza varchar(200) not null,
	id_aseguradora varchar(10) not null, --FK
	constraint poliza_PK primary key(id_poliza)
);

alter table practica.poliza 
add constraint poliza_aseguradora_FK foreign key (id_aseguradora)
references practica.aseguradora(id_aseguradora);


--AÑADIDA FOREIGN KEY IDPOLIZA A TABLE COCHE

alter table practica.coche  
add constraint coche_poliza_FK foreign key (id_poliza)
references practica.poliza(id_poliza);

-- CREAR TABLES REVISIONES Y DIVISA

create table practica.divisa(
	id_divisa varchar(10) not null, --PK
	cambio_dolar float not null,
	nombre varchar(200) not null,
	constraint divisa_PK primary key(id_divisa)
);

create table practica.hist_revisiones(
	id_revision varchar(10) not null, --PK
	id_coche varchar(10) not null, 
	fecha_revision date not null,
	importe_revision float not null,
	km_revision integer not null,
	id_divisa varchar(10) not null, 
	constraint hist_revisiones_PK primary key(id_revision)
);

alter table practica.hist_revisiones  
add constraint hist_revisiones_divisa_FK foreign key (id_divisa)
references practica.divisa(id_divisa);

alter table practica.hist_revisiones  
add constraint hist_revisiones_coche_FK foreign key (id_coche)
references practica.coche(id_coche);

--INSERCIÓN DATOS tabla grupo coche

insert into practica.grupo_coche(id_grupo, nombre)
values ('001','Jaguar Land Rover');

insert into practica.grupo_coche(id_grupo, nombre)
values ('002','Volkswagen');

insert into practica.grupo_coche(id_grupo, nombre)
values ('003','Grupo Toyota');

--INSERCIÓN DATOS tabla marca

insert into practica.marca(id_marca, nombre, id_grupo)
values ('001','Jaguar','001');

insert into practica.marca(id_marca, nombre, id_grupo)
values ('002','Land Rover','001');

insert into practica.marca(id_marca, nombre, id_grupo)
values ('003','Porsche','002');

insert into practica.marca(id_marca, nombre, id_grupo)
values ('004','Audi','002');

insert into practica.marca(id_marca, nombre, id_grupo)
values ('005','Toyota','003');

insert into practica.marca(id_marca, nombre, id_grupo)
values ('006','Lexus','003');

--INSERCIÓN DATOS tabla modelo

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('001','E-PACE','001');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('002','F-PACE','001');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('003','Discovery','002');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('004','Defender','002');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('005','Panamera','003');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('006','Macan','003');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('007','A5','004');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('008','A6','004');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('009','RAV4','005');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('010','Yaris','005');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('011','RX 450h','006');

insert into practica.modelo(id_modelo, nombre, id_marca)
values ('012','UX 300e','006');

--- INSERCION DE DATOS tabla divisa

insert into practica.divisa(id_divisa, cambio_dolar, nombre)
values ('001',1,'Dolar Americano');

insert into practica.divisa(id_divisa, cambio_dolar, nombre)
values ('002',1.10 ,'Euro');

--- INSERCION DE DATOS tabla aseguradora

insert into practica.aseguradora(id_aseguradora, nombre)
values ('001','Mapfre');

insert into practica.aseguradora(id_aseguradora, nombre)
values ('002','DKV');

insert into practica.aseguradora(id_aseguradora, nombre)
values ('003','Linea Directa');

-- INSERCIÓN DE DATOS tabla coche y seguidamente la poliza del coche (si esta asegurado)
insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('001','9315KZX',47865,'2004-09-04','negro','001');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('001','876052456','001');

update practica.coche
set id_poliza = '001'
where id_coche = '001';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('002','9315HJX',23565,'20120-11-02','rojo','002');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('002','836082353','002');

update practica.coche
set id_poliza = '002'
where id_coche = '002';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('003','2345KXL',21198,'2022-02-10','azul','003');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('003','636098763','003');

update practica.coche
set id_poliza = '003'
where id_coche = '003';



insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('004','2115JLL',14645,'2012-01-15','amarillo','004');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('004','536048263','002');

update practica.coche
set id_poliza = '004'
where id_coche = '004';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('005','3455KLL',104347,'2002-10-23','negro','005');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('005','636078263','002');

update practica.coche
set id_poliza = '005'
where id_coche = '005';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('006','2769LKM',76543,'2019-03-29','rojo','006');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('006','936078263','001');

update practica.coche
set id_poliza = '006'
where id_coche = '006';



insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('007','6785KLM',10247,'2021-01-29','negro','006');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('007','836098263','003');

update practica.coche
set id_poliza = '007'
where id_coche = '007';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('008','9834ZZZ',11347,'2011-03-29','azul','009');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('008','136398263','002');

update practica.coche
set id_poliza = '008'
where id_coche = '008';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('009','5847XZZ',1112347,'2000-03-24','amarillo','010');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('009','233489263','001');

update practica.coche
set id_poliza = '009'
where id_coche = '009';


insert into practica.coche(id_coche, matricula, km_totales, fecha_compra, color, id_modelo)
values ('010','7847XJZ',712347,'2017-03-24','granate','012');

insert into practica.poliza(id_poliza, numero_poliza, id_aseguradora)
values ('010','568485463','003');

update practica.coche
set id_poliza = '010'
where id_coche = '010';

-- INSERCIÓN DE DATOS DE REVISIONES HISTÓRICAS -

insert into practica.hist_revisiones(id_revision, id_coche, fecha_revision, importe_revision, km_revision, id_divisa)
values ('001','001','2019-03-03', 450.98, 1500,'002');

insert into practica.hist_revisiones(id_revision, id_coche, fecha_revision, importe_revision, km_revision, id_divisa)
values ('002','001','2020-03-10', 650, 1500,'002');


insert into practica.hist_revisiones(id_revision, id_coche, fecha_revision, importe_revision, km_revision, id_divisa)
values ('003','004','2016-01-23', 950, 11500,'002');

insert into practica.hist_revisiones(id_revision, id_coche, fecha_revision, importe_revision, km_revision, id_divisa)
values ('004','004','2018-02-14', 1290.3, 31500,'002');

select * from practica.coche


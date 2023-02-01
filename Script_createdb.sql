create schema practica authorization sajesrgs;

create table practica.coche(
	id_coche varchar(10) not null, --PK
	nombre varchar(200) not null,
	matricula varchar(200) not null,
	km_totales integer not null, 
	fecha_compra date not null,
	color varchar(200) not null,
	id_modelo varchar(10) not null,  --FK
	id_poliza varchar(10) not null,  --FK
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
	id_aseguradora varchar(10) not null,
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
	importe_revision integer not null,
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
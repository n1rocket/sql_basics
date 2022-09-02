/*
 *  Parte 2 Dia 3. Creamos script y datos del modelo ER de empleados.
 */


-- creamos esquema propio

create schema personalmaster authorization oodhuafv;


/*
	Tablas de Persona ---------
*/

--Tipo documentos
create table personalmaster.type_docs(
	type_doc varchar(20) not null, -- PK
	name varchar(200) not null,
	description varchar(512) null
);
alter table personalmaster.type_docs
add constraint type_docs_PK primary key (type_doc);

-- Tabla de generos

create table personalmaster.type_gender(
	gender varchar(20) not null, -- PK
	name varchar(200) not null,
	description varchar(512) null
);

alter table personalmaster.type_gender
add constraint type_gender_PK primary key(gender);

-- Tabla persona. 

create table personalmaster.person(
	id_person varchar(10) not null, -- PK
	name varchar(50) not null,
	apell1 varchar(50) not null,
	apell2 varchar(50) null, -- Segundo apellido opcional (No españoles)
	dt_birth date not null,
	type_doc varchar(20) not null , -- FK type_docs()
	legal_id varchar(50) not null,
	email varchar(255) null,
	phone varchar(50) null,
	gender varchar(20) not null, --FK
	description varchar(512) null
);

-- PK
alter table personalmaster.person
add constraint person_PK primary key (id_person);

-- FK's
alter table personalmaster.person
add constraint person_type_doc_FK 
				foreign key (type_doc) 
				references personalmaster.type_docs (type_doc);


alter table personalmaster.person
add constraint person_gender_FK
				foreign key(gender)
				references personalmaster.type_gender(gender);



--Cargamos los datos de personas y sus tablas de referencia

--type docs		
select distinct type_doc
from public.person	

			
insert into personalmaster.type_docs(type_doc, name, description) 
values ('NIF', 'DNI/NIF España', 'Documentos oficiales Españoles');

insert into personalmaster.type_docs(type_doc, name, description) 
values ('PASS', 'Pasaporte', 'Documento intrernacional pasaporte');		
			
select * from personalmaster.type_docs		
		
-- Gender
			
select distinct gender from public.person

insert into personalmaster.type_gender (gender, name) values('MUJER','Mujer');
insert into personalmaster.type_gender (gender, name) values('HOMBRE','Hombre');
insert into personalmaster.type_gender (gender, name) values('NO DEFINIDO','N/D');
insert into personalmaster.type_gender (gender, name) values('FLUIDO','Genero Fluido');

select * from personalmaster.type_gender
			

-- Personas ---

insert into personalmaster.person 
(id_person, name, apell1, apell2, dt_birth, type_doc, legal_id, email, phone, gender, description)
select id_person , name, apell1 , apelli2 , dt_birth , type_doc , 
       legal_id , email, phone , gender , 'Carga inicial'
from public.person;
			
select * from personalmaster.person
			
			
			
-- integriudad referencial...
delete from personalmaster.type_gender 
where gender  = 'FLUIDO'







/*
	Tablas de Empleados ---------
*/

create table personalmaster.motivos(
	id_reason varchar(10) not null, --PK
	name varchar(256) not null,
	description varchar(512) null
);

--PK 
alter table personalmaster.motivos
add constraint motivos_PK primary key(id_reason);
			
		
-- cargar los motivos

select distinct reason_hire  from public.employees;
select distinct reason_termination  from public.employees;

insert into personalmaster.motivos (id_reason, name)
values ('01','Nueva Alta');

insert into personalmaster.motivos (id_reason, name)
values ('02','Sin motivo');

--Me hago una copia , solo para mi y temporal, de la tablad de empleados.
create table personalmaster.employees_aux_borrar
as
select * from public.employees;

-- A partir de ahora no usamos employees sino employees_aux_borrar
select * from personalmaster.employees_aux_borrar

-- cmabir los motivos por los nuevos codigos

update personalmaster.employees_aux_borrar
set reason_hire  = '01';

update personalmaster.employees_aux_borrar
set reason_termination  = '02';

-- Tablas de tipo de contratacion

create table personalmaster.tpcontratacion(
	idtipocontratacion varchar(100) not null,
	name varchar(50) not null,
	description varchar(512) null
);

--PK
alter table personalmaster.tpcontratacion
add constraint  tpcontratacion_PK primary key(idtipocontratacion);

--cargamos los datos

select distinct employee_type  from personalmaster.employees_aux_borrar

insert into personalmaster.tpcontratacion (idtipocontratacion, name)
values ('01','Empleado');
insert into personalmaster.tpcontratacion (idtipocontratacion, name)
values ('02','Profesional/Frelance');

update personalmaster.employees_aux_borrar
set employee_type  = '01'
where employee_type  = 'EMPLEADO';

update personalmaster.employees_aux_borrar
set employee_type  = '02'
where employee_type  = 'PROFESIONAL';


-- Puestos
create table personalmaster.jobs(
	idjob varchar(100) not null, --PK
	name varchar(256) not null,
	description varchar(256) null
);

--PK
alter table personalmaster.jobs
add constraint jobs_PK primary key(idjob);


select distinct job  from personalmaster.employees_aux_borrar

insert into personalmaster.jobs (idjob, name) values ('01','DISEÑADOR');
insert into personalmaster.jobs (idjob, name) values ('02','MAQUETADOR');
insert into personalmaster.jobs (idjob, name) values ('03','PROGRAMADOR');
insert into personalmaster.jobs (idjob, name) values ('04','IOS JUNIOR');
insert into personalmaster.jobs (idjob, name) values ('05','EXPERTO EN REDES NEURONALES');
insert into personalmaster.jobs (idjob, name) values ('06','PROG. WEB ANGULAR');
insert into personalmaster.jobs (idjob, name) values ('07','IOS SENIOR');
insert into personalmaster.jobs (idjob, name) values ('08','ANALISTA');
insert into personalmaster.jobs (idjob, name) values ('09','DISEÑADOR JUNIOR');
insert into personalmaster.jobs (idjob, name) values ('10','EXPERTO NLP');
insert into personalmaster.jobs (idjob, name) values ('11','PROG. WEB REACT');
insert into personalmaster.jobs (idjob, name) values ('12','ANDROID SENIOR');
insert into personalmaster.jobs (idjob, name) values ('13','DISEÑADOR SENIOR');
insert into personalmaster.jobs (idjob, name) values ('14','CIENTIFICO DE DATOS');
insert into personalmaster.jobs (idjob, name) values ('15','EXPERTO ML');
insert into personalmaster.jobs (idjob, name) values ('16','PROFESIONAL');



select * from personalmaster.employees_aux_borrar
update personalmaster.employees_aux_borrar set job = '01' WHERE job = 'DISEÑADOR';
update personalmaster.employees_aux_borrar set job = '02' WHERE job = 'MAQUETADOR';
update personalmaster.employees_aux_borrar set job = '03' WHERE job = 'PROGRAMADOR';
update personalmaster.employees_aux_borrar set job = '04' WHERE job = 'IOS JUNIOR';
update personalmaster.employees_aux_borrar set job = '05' WHERE job = 'EXPERTO EN REDES NEURONALES';
update personalmaster.employees_aux_borrar set job = '06' WHERE job = 'PROG. WEB ANGULAR';
update personalmaster.employees_aux_borrar set job = '07' WHERE job = 'IOS SENIOR';
update personalmaster.employees_aux_borrar set job = '08' WHERE job = 'ANALISTA';
update personalmaster.employees_aux_borrar set job = '09' WHERE job = 'DISEÑADOR JUNIOR';
update personalmaster.employees_aux_borrar set job = '10' WHERE job = 'EXPERTO NLP';
update personalmaster.employees_aux_borrar set job = '11' WHERE job = 'PROG. WEB REACT';
update personalmaster.employees_aux_borrar set job = '12' WHERE job = 'ANDROID SENIOR';
update personalmaster.employees_aux_borrar set job = '13' WHERE job = 'DISEÑADOR SENIOR';
update personalmaster.employees_aux_borrar set job = '14' WHERE job = 'CIENTIFICO DE DATOS';
update personalmaster.employees_aux_borrar set job = '15' WHERE job = 'EXPERTO ML';
update personalmaster.employees_aux_borrar set job = '16' WHERE job = 'PROFESIONAL';




-- Tabla de empleados

create table personalmaster.employees(
	id_person varchar(10) not null, --PK
	dt_hire date not null, --PK
	dt_termination date not null default '4000-01-01',
	dt_seniority date not null default '4000-01-01',
	id_reason_hire varchar(100) not null, --FK
	id_reason_termination varchar(100) not null, --FK
	idtpcontratacion varchar(100) not null --FK
);

--PK
alter table personalmaster.employees
add constraint employees_PK primary key(id_person,dt_hire);

--FK

alter table personalmaster.employees
add constraint employees_person_FK foreign key (id_person)
references personalmaster.person(id_person);

alter table personalmaster.employees
add constraint employees_motivo_alta_FK foreign key (id_reason_hire)
references personalmaster.motivos(id_reason);

alter table personalmaster.employees
add constraint employees_motivo_baja_FK foreign key (id_reason_termination)
references personalmaster.motivos(id_reason);


alter table personalmaster.employees
add constraint employees_ticontratacion_FK foreign key (idtpcontratacion)
references personalmaster.tpcontratacion(idtipocontratacion);


--cargamos los empleados

insert into personalmaster.employees
(id_person, dt_hire, dt_termination, dt_seniority, id_reason_hire, id_reason_termination, idtpcontratacion)
select id_person, dt_hire, dt_termination, dt_seniority, reason_hire , reason_termination , employee_type
from personalmaster.employees_aux_borrar

select * from personalmaster.employees



--- Historico de puestos


create table personalmaster.hist_jobs_employee (

	id_person varchar(10) not null, --PK, FK
	dt_hire date not null, --PK, FK
	dt_start date not null, --PK
	dt_end date not null default '4000-01-01',
	id_job varchar(100) not null --FK
);

--PK
alter table personalmaster.hist_jobs_employee
add constraint hist_jobs_employee_PK primary key (id_person, dt_hire,dt_start );


--FK
alter table personalmaster.hist_jobs_employee
add constraint hist_jobs_employee_FK foreign key (id_person, dt_hire) 
references personalmaster.employees(id_person,dt_hire); --FK empleado

alter table personalmaster.hist_jobs_employee
add constraint hist_jobs_employee_job_FK foreign key (id_job) 
references personalmaster.jobs(idjob); --FK jobs (puestos)


-- Cargar los datos hist. puestos

insert into personalmaster.hist_jobs_employee
(id_person, dt_hire, dt_start,dt_end,id_job  )
select id_person, dt_hire, dt_hire, dt_termination , job
from personalmaster.employees_aux_borrar;

select * from personalmaster.hist_jobs_employee


update personalmaster.person
set apell2  = null 
where id_person  = '000333'






--------- SQL consultas -------
/*
Case when... end. -> CUando haya  valores NULL es muy util
*/

select a.id_person , a.dt_hire , b."name" , b.apell1 , b.apell2 , c.id_job , d.name ,

case 
	
	when b.apell2 is null then b.name || ' ' || b.apell1 --sin apellido 2
	when b.apell2 is not null then b.name || ' ' || b.apell1 || ' ' || b.apell2 -- con apellido 2
end

,
b.name || ' ' || b.apell1 || ' ' || b.apell2

from personalmaster.employees a 
inner join personalmaster.person b on a.id_person  = b.id_person 
inner join personalmaster.hist_jobs_employee c on a.id_person  = c.id_person and a.dt_hire  = c.dt_hire
inner join personalmaster.jobs d on c.id_job  = d.idjob 
where a.dt_termination = '4000-01-01' and a.idtpcontratacion  = '01' and c.id_job  = '07'


select * from personalmaster.jobs



-













-------------------
--DDL 
-------------------


-- Creamos tabla de series

create table series(
	--Aqui las columnas de la tabla
	idserie varchar(10),
	nombre varchar(200),
	anio_creation integer
);

drop table series; --Elimina la tabla (estructra + datos)


-- Creamos la tabla de series con control de nulos y PK

create table series(
	idserie varchar(10) not null, --PK
	nombre varchar(200) not null,
	anio_creation integer not null,
	commentario varchar(512) null,
	
	--Definimos la PK
	constraint series_PK primary key(idserie)
);


-- Añadimos una columna y despues la borramos. Ojo no trabajar sin copia de seguridad

alter table series
add column plataforma text null;


alter table series 
drop column plataforma; -- Ojo si hay datos se pierden


-- Crear la tabla de Temporadas de una serie

create table temporadas(
	idserie varchar(10) not null, --PK y FK (series->idserie)
	num_temporada integer not null, --PK
	anio integer not null,
	titulo varchar(200) not null,
	comentarios varchar(512) null
);

-- PK temporadas
alter table temporadas
add constraint temporadas_PK primary key(idserie,num_temporada);

--borrar constraint
alter table  temporadas 
drop constraint temporadas_PK;


-- FK temporadas -> series
alter table temporadas
add constraint temporadas_series_FK foreign key(idserie) references series(idserie);

/*
 *  Fk con Delete Cascade
 alter table temporadas
 add constraint temporadas_series_FK foreign key(idserie) 
 references series(idserie) on delete cascade;


 
 */

-------------------
-- DML 
-------------------

insert into series (idserie, nombre, anio_creation)
values ('0002','Juego de tronos', 2011);

insert into series (idserie, nombre, anio_creation)
values ('0003','Hermanos de Sangre', 2001);

--Ver lo que hay en la tabla
select * from series

insert into series (idserie, nombre, anio_creation, commentario)
values ('0004','Thor', 2021, '');

-- Falla porque no existe la serie
insert into temporadas (idserie, num_temporada, anio, titulo)
values ('zz', 1, 2008, 'Temporada 1');

-- Cargamos las temporadas
insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0001', 1, 2008, 'Temporada 1');

insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0001', 2, 2009, 'Temporada 2');

insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0001', 3, 2010, 'Temporada 3');

insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0001', 4, 2011, 'Temporada 3');


insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0002', 1, 2011, 'Temporada 1 JDT');

insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0002', 2, 2012, 'Temporada 2 JDT');

insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0002', 3, 2013, 'Temporada 3 JDT');

insert into temporadas (idserie, num_temporada, anio, titulo)
values ('0003', 1, 2001, 'Temporada Unica');



select * from series;
select * from temporadas;


---- comando SELECT ----
-- * = TODAS LAS COLUMNAS

select * 
from temporadas

-- filtamos por juego de tronos
select idserie , num_temporada , anio, titulo , comentarios 
from temporadas
where idserie  = '0002'


-- filtamos por juego de tronos y la temporada 2
select idserie , num_temporada , anio, titulo , comentarios 
from temporadas
where idserie  = '0002' and (num_temporada = 1 or num_temporada = 2)

select idserie , num_temporada , anio, titulo , comentarios 
from temporadas
where idserie  = '0002' and num_temporada  in (1,2)


select idserie , num_temporada , anio, titulo , comentarios 
from temporadas
where idserie  = '0002' and num_temporada = 1 or num_temporada = 2

-- temporadas cuyp año > 2010
select *
from temporadas 
where anio >= 2010

/*
 > - Mayor
 >= mayor igual
 < Menor
 <= Menor o igual
 <> distinto
 = igual
 like - Contine
 */

--filtramos por campo a null que contenga algo
select *
from temporadas 
where comentarios like '%hola%'

-- vacios
select *
from temporadas 
where comentarios is NULL

-- NO VACIOS
select *
from temporadas 
where comentarios is NOT null

-- ORDENAR LOS DATOS
select *
from temporadas 
where comentarios is null
order by anio asc, num_temporada  asc


-- DISTINCT

select distinct idserie , anio
from temporadas 
where anio >= 2010


---- DELETE ----

select * from series s 


select * from series where idserie  = '0001';
delete from series where idserie  = '0001';


---- UPDATE ---
select *
from temporadas t 

update temporadas 
set titulo  = 'Temporada unica hermanos de sangre', 
    comentarios  = 'actualizada'
where idserie  = '0003' and num_temporada = 1

select t.* 
from temporadas t -- t es un alias
where t.idserie  = '0003' and t.num_temporada = 1


---- SELECT AVANZADO -------

select COUNT(*)
from temporadas 
where num_temporada = 1

select count(*), min(num_temporada), max(num_temporada), 
sum(num_temporada), avg(num_temporada)
from temporadas 
where idserie = '0001'


select idserie, count(*)
from temporadas 
group by idserie

-- importante: - ponemos en el select las columnas que agrupamos + funciones de agrupacion
--             - Having solo por los campos de la select
select idserie, count(*)
from temporadas 
where 1 = 1
group by idserie  --, <otra columna>
having count(*) > 1 --el where para el group by

-- UNION ALL ---
select idserie, nombre from series where idserie  = '0001'
union all
select idserie , titulo from temporadas   where idserie  = '0002'

create table temp1
as 
select idserie, nombre from series where idserie  = '0001'
union all
select idserie , titulo from temporadas   where idserie  = '0002'

select * from temp1

select   position('de' in nombre);
from series 









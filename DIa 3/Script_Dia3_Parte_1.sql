select b.nombre, a.num_temporada , a.anio 
from temporadas a, series b /*, actores c*/
where a.idserie = b.idserie and a.anio = 2011 
order by b.nombre asc, a.num_temporada asc 

-- refactor
select b.nombre, a.num_temporada , a.anio 
from temporadas a inner join series b on a.idserie = b.idserie 
/*,temporadas a inner join actores c on a.id_actor = c.id_actor ,*/
order by b.nombre asc, a.num_temporada asc 


-- outter join (right join)

select b.nombre, a.num_temporada , a.anio 
from temporadas a right join series b on a.idserie = b.idserie 

select b.nombre, a.num_temporada , a.anio 
from  series b /*tabla base */ left join temporadas  a on a.idserie = b.idserie 


-- EMPLEADOS DEL DEPARTAMENTO MOBILE

select a.id_person , a.dt_hire , a.job , b.apell1  || ' ' || b.apelli2  || ', ' || b.name 
from public.employees a inner join public.person b on a.id_person  = b.id_person 
where department = 'MOBILE'


















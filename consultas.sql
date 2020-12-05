/*==============================================================*/
/* Consulta 1: Mostrar todas las citas que han ocurrido         */
/*==============================================================*/
SELECT usuario_nombre as usuario_uno, usuario_dos, cita_fecha ||' '|| cita_hora as fecha_cita
FROM USUARIOCITA
inner join USUARIO on usuario.usuario_id = usuariocita.usuariocita_uno
inner join PAREJA on usuariocita.usuariocita_dos = pareja.id_dos
inner join CITA on usuariocita.usuariocita_cita_id = cita.cita_id

/*==============================================================*/
/* Consulta 2: Mostrar las citas que ha tenido cada usuario     */
/*==============================================================*/
with recursive CANTIDAD(usuario_nombre, cantidad_citas) as (
   SELECT usuario_nombre as nombre, count(usuariocita_uno)
   FROM USUARIO inner join USUARIOCITA on usuario.usuario_id = usuariocita.usuariocita_uno
   group by usuario_nombre
   union all
   SELECT usuario_nombre, count(usuariocita_dos)
   FROM USUARIO inner join USUARIOCITA on usuario.usuario_id = usuariocita.usuariocita_dos
   group by usuario_nombre
)
SELECT * FROM CANTIDAD

/*==============================================================*/
/* Consulta 3: Usuarios que han tenido más citas                */
/*==============================================================*/
with recursive CANTIDAD(usuario_nombre, cantidad_citas) as (
   SELECT usuario_nombre as nombre, count(usuariocita_uno)
   FROM USUARIO inner join USUARIOCITA on usuario.usuario_id = usuariocita.usuariocita_uno
   group by usuario_nombre
   union all
   SELECT usuario_nombre, count(usuariocita_dos)
   FROM USUARIO inner join USUARIOCITA on usuario.usuario_id = usuariocita.usuariocita_dos
   group by usuario_nombre
)
SELECT * FROM CANTIDAD order by cantidad_citas desc
FETCH FIRST 2 ROWS ONLY

/*==============================================================*/
/* Consulta 4: Usuarios que no han tenido ninguna cita          */
/*==============================================================*/
with recursive CANTIDAD(usuario_nombre) as (
   SELECT usuario_nombre as nombre, usuariocita_id
   FROM USUARIO left join USUARIOCITA on usuario.usuario_id = usuariocita.usuariocita_uno
   where usuariocita_uno isnull
   group by usuario_nombre, usuariocita_id
   union all
   SELECT usuario_nombre, usuariocita_id
   FROM USUARIO left join USUARIOCITA
   on usuario_id = usuariocita.usuariocita_dos
   where usuariocita_dos isnull
   group by usuario_nombre, usuariocita_id
)
SELECT usuario_nombre FROM CANTIDAD
group by usuario_nombre
HAVING COUNT(*) > 1;

/*==============================================================*/
/* Consulta 5: Valoración de citas de cada usuario              */
/*==============================================================*/
SELECT usuario_nombre, round(avg(calificacion_estrella), 2) as promedio
FROM USUARIO inner join CALIFICACION on usuario.usuario_id = calificacion.calificacion_usuario_id
group by usuario_nombre
order by promedio desc

/*==============================================================*/
/* Consulta 6: Usuarios con la peor calificacion                */
/*==============================================================*/
SELECT usuario_nombre, round(avg(calificacion_estrella), 2) as promedio
FROM USUARIO inner join CALIFICACION on usuario.usuario_id = calificacion.calificacion_usuario_id
group by usuario_nombre
having avg(calificacion_estrella) < 4
order by usuario_nombre asc
/*==============================================================*/
/* Tabla: PAIS                                                  */
/*==============================================================*/
CREATE TABLE PAIS(
    pais_id serial PRIMARY KEY,
    pais_nombre varchar(15)
);

/*==============================================================*/
/* Tabla: CIUDAD                                                */
/*==============================================================*/
CREATE TABLE CIUDAD(
    ciudad_id serial PRIMARY KEY,
    ciudad_nombre varchar(15)
);

/*==============================================================*/
/* Tabla: MÚSICA                                                */
/*==============================================================*/
CREATE TABLE MUSICA(
    musica_id serial PRIMARY KEY,
    musica_nombre varchar(15)
);

/*==============================================================*/
/* Tabla: DEPORTE                                               */
/*==============================================================*/
CREATE TABLE DEPORTE(
    deporte_id serial PRIMARY KEY,
    deporte_nombre varchar(15)
);

/*==============================================================*/
/* Tabla: HOBBY                                                 */
/*==============================================================*/
CREATE TABLE HOBBY(
    hobby_id serial PRIMARY KEY,
    hobby_nombre varchar(15)
);

/*==============================================================*/
/* Tabla: CITA                                                  */
/*==============================================================*/
CREATE TABLE CITA(
    cita_id serial PRIMARY KEY,
    cita_fecha date,
    cita_hora time
);

/*==============================================================*/
/* Tabla: USUARIO                                               */
/*==============================================================*/
CREATE TABLE USUARIO(
    usuario_id serial PRIMARY KEY,
    usuario_nombre varchar(10),
    usuario_apellido varchar(10),
    usuario_fecha date,
    usuario_hora time,
    usuario_pais_id serial,
    usuario_ciudad_id serial,

CONSTRAINT pais_FK FOREIGN KEY (usuario_pais_id) REFERENCES PAIS (pais_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT ciudad_FK FOREIGN KEY (usuario_ciudad_id) REFERENCES CIUDAD (ciudad_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);


/*==============================================================*/
/* Tabla: HOBBYUSUARIO                                          */
/*==============================================================*/
CREATE TABLE HOBBYUSUARIO(
    hobbyusuario_id serial PRIMARY KEY,
    hobbyusuario_hobby_id serial,
    hobbyusuario_usuario_id serial,

CONSTRAINT hu_hobby_FK FOREIGN KEY (hobbyusuario_hobby_id) REFERENCES HOBBY (hobby_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT hu_usuario_FK FOREIGN KEY (hobbyusuario_usuario_id) REFERENCES USUARIO (usuario_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

/*==============================================================*/
/* Tabla: DEPORTEUSUARIO                                        */
/*==============================================================*/
CREATE TABLE DEPORTEUSUARIO(
    deporteusuario_id serial PRIMARY KEY,
    deporteusuario_deporte_id serial,
    deporteusuario_usuario_id serial,

CONSTRAINT du_deporte_FK FOREIGN KEY (deporteusuario_deporte_id) REFERENCES DEPORTE (deporte_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT du_usuario_FK FOREIGN KEY (deporteusuario_usuario_id) REFERENCES USUARIO (usuario_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

/*==============================================================*/
/* Tabla: MUSICAUSUARIO                                         */
/*==============================================================*/
CREATE TABLE MUSICAUSUARIO(
    musicausuario_id serial PRIMARY KEY,
    musicausuario_musica_id serial,
    musicausuario_usuario_id serial,

CONSTRAINT mu_musica_FK FOREIGN KEY (musicausuario_musica_id) REFERENCES MUSICA (musica_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT mu_usuario_FK FOREIGN KEY (musicausuario_usuario_id) REFERENCES USUARIO (usuario_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

/*==============================================================*/
/* Tabla: USUARIOCITA                                           */
/*==============================================================*/
CREATE TABLE USUARIOCITA(
    usuariocita_id serial,
    usuariocita_uno serial,
    usuariocita_dos serial,
    usuariocita_cita_id serial,

CONSTRAINT usuario_uno_FK FOREIGN KEY (usuariocita_uno) REFERENCES USUARIO (usuario_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT usuario_dos_FK FOREIGN KEY (usuariocita_dos) REFERENCES USUARIO (usuario_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT cita_id_FK FOREIGN KEY (usuariocita_cita_id) REFERENCES CITA (cita_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

/*==============================================================*/
/* Tabla: CALIFICACION                                          */
/*==============================================================*/
CREATE TABLE CALIFICACION(
    calificacion_id serial PRIMARY KEY,
    calificacion_usuario_id serial,
    calificacion_cita_id serial,
    calificacion_estrella smallint,
    calificacion_descripcion varchar(75),

CONSTRAINT calificacion_FK FOREIGN KEY (calificacion_usuario_id) REFERENCES USUARIO (usuario_id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT cita_id_FK FOREIGN KEY (calificacion_cita_id) REFERENCES CITA (cita_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

/*==============================================================*/
/* Vista: PAREJA                                                */
/*==============================================================*/
create view PAREJA as
select usuario_id as id_dos, usuario_nombre as usuario_dos FROM usuario;

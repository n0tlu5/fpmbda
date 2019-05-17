/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     15-May-19 11:42:56                           */
/*==============================================================*/


alter table MODUL
   drop constraint FK_MODUL_REFERENCE_USER;

alter table MODUL
   drop constraint FK_MODUL_REFERENCE_KOMUNITA;

alter table PENGUMUMAN
   drop constraint FK_PENGUMUM_REFERENCE_USER;

alter table PENGUMUMAN
   drop constraint FK_PENGUMUM_REFERENCE_KOMUNITA;

alter table POST
   drop constraint FK_POST_REFERENCE_KOMUNITA;

alter table POST
   drop constraint FK_POST_REFERENCE_USER;

alter table REPLY
   drop constraint FK_REPLY_REFERENCE_POST;

alter table REPLY
   drop constraint FK_REPLY_REFERENCE_USER;

alter table SYARAT
   drop constraint FK_SYARAT_REFERENCE_MODUL_4;

alter table SYARAT
   drop constraint FK_SYARAT_REFERENCE_MODUL_3;

alter table USER_KOMUNITAS
   drop constraint FK_USER_KOM_REFERENCE_USER_1;

alter table USER_KOMUNITAS
   drop constraint FK_USER_KOM_REFERENCE_KOMUNITA;

alter table USER_KOMUNITAS
   drop constraint FK_USER_KOM_REFERENCE_USER_2;

alter table USER_MODUL
   drop constraint FK_USER_MOD_REFERENCE_USER;

alter table USER_MODUL
   drop constraint FK_USER_MOD_REFERENCE_MODUL;

drop table KOMUNITAS cascade constraints;

drop table MODUL cascade constraints;

drop table PENGUMUMAN cascade constraints;

drop table POST cascade constraints;

drop table REPLY cascade constraints;

drop table SYARAT cascade constraints;

drop table USERS cascade constraints;

drop table USER_KOMUNITAS cascade constraints;

drop table USER_MODUL cascade constraints;

/*==============================================================*/
/* Table: KOMUNITAS                                             */
/*==============================================================*/
create table KOMUNITAS  ( -- UDAH
   KMT_ID               CHAR(10)                        not null,
   KMT_NAMA             VARCHAR2(20),
   KMT_DESKRIPSI        VARCHAR2(200),
   constraint PK_KOMUNITAS primary key (KMT_ID)
);

/*==============================================================*/
/* Table: MODUL                                                 */
/*==============================================================*/
create table MODUL  ( -- 5 modul per komunitas
   MD_ID                CHAR(10)                        not null,
   KMT_ID               CHAR(10),
   USR_ID               CHAR(10),
   MD_NAMA              VARCHAR2(20),
   MD_KONTEN            CLOB,
   MD_SUBMIT            SMALLINT,
   constraint PK_MODUL primary key (MD_ID)
);

/*==============================================================*/
/* Table: PENGUMUMAN                                            */
/*==============================================================*/
create table PENGUMUMAN  ( -- 2 per komunitas
   PNG_ID               CHAR(10)                        not null,
   KMT_ID               CHAR(10),
   USR_ID               CHAR(10),
   PNG_NAMA             VARCHAR2(20)                    not null,
   PNG_KONTEN           CLOB                            not null,
   PNG_TGLTAMPIL        DATE                            not null,
   PNG_TGLSELESAI       DATE                            not null,
   constraint PK_PENGUMUMAN primary key (PNG_ID)
);

/*==============================================================*/
/* Table: POST                                                  */
/*==============================================================*/
create table POST  ( -- 2 per komunitas
   POST_ID              CHAR(10)                        not null,
   KMT_ID               CHAR(10),
   USR_ID               CHAR(10),
   POST_JUDUL           VARCHAR2(150),
   POST_KONTEN          CLOB,
   constraint PK_POST primary key (POST_ID)
);

/*==============================================================*/
/* Table: REPLY                                                 */
/*==============================================================*/
create table REPLY  ( -- 3 per post
   RPL_ID               CHAR(10)                        not null,
   POST_ID              CHAR(10),
   USR_ID               CHAR(10),
   RPL_KONTEN           CLOB,
   constraint PK_REPLY primary key (RPL_ID)
);

/*==============================================================*/
/* Table: SYARAT                                                */
/*==============================================================*/
create table SYARAT  ( -- sesuai MODUL
   MD_ID                CHAR(10)                        not null,
   MOD_MD_ID            CHAR(10)                        not null,
   constraint PK_SYARAT primary key (MD_ID, MOD_MD_ID)
);

/*==============================================================*/
/* Table: USERS                                                */
/*==============================================================*/
create table USERS  ( -- UDAH
   USR_ID               CHAR(10)                        not null,
   USR_NRP              CHAR(15)                        not null,
   USR_NAMA             VARCHAR2(20)                    not null,
   USR_EMAIL            VARCHAR2(100)                   not null,
   constraint PK_USER primary key (USR_ID)
);

/*==============================================================*/
/* Table: USER_KOMUNITAS                                        */
/*==============================================================*/
create table USER_KOMUNITAS  ( -- UDAH
   USR_ID               CHAR(10)                        not null,
   KMT_ID               CHAR(10)                        not null,
   ADM_USR_ID           CHAR(10),
   STATUS               SMALLINT,
   constraint PK_USER_KOMUNITAS primary key (USR_ID, KMT_ID)
);

/*==============================================================*/
/* Table: USER_MODUL                                            */
/*==============================================================*/
create table USER_MODUL  ( -- sesuai MODUL
   USR_ID               CHAR(10)                        not null,
   MD_ID                CHAR(10)                        not null,
   SUBMISSION           SMALLINT,
   STATUS_SELESAI       SMALLINT,
   constraint PK_USER_MODUL primary key (USR_ID, MD_ID)
);

alter table MODUL
   add constraint FK_MODUL_REFERENCE_USER foreign key (USR_ID)
      references USERS (USR_ID);

alter table MODUL
   add constraint FK_MODUL_REFERENCE_KOMUNITA foreign key (KMT_ID)
      references KOMUNITAS (KMT_ID);

alter table PENGUMUMAN
   add constraint FK_PENGUMUM_REFERENCE_USER foreign key (USR_ID)
      references USERS (USR_ID);

alter table PENGUMUMAN
   add constraint FK_PENGUMUM_REFERENCE_KOMUNITA foreign key (KMT_ID)
      references KOMUNITAS (KMT_ID);

alter table POST
   add constraint FK_POST_REFERENCE_KOMUNITA foreign key (KMT_ID)
      references KOMUNITAS (KMT_ID);

alter table POST
   add constraint FK_POST_REFERENCE_USER foreign key (USR_ID)
      references USERS (USR_ID);

alter table REPLY
   add constraint FK_REPLY_REFERENCE_POST foreign key (POST_ID)
      references POST (POST_ID);

alter table REPLY
   add constraint FK_REPLY_REFERENCE_USER foreign key (USR_ID)
      references USERS (USR_ID);

alter table SYARAT
   add constraint FK_SYARAT_REFERENCE_MODUL_4 foreign key (MOD_MD_ID)
      references MODUL (MD_ID);

alter table SYARAT
   add constraint FK_SYARAT_REFERENCE_MODUL_3 foreign key (MD_ID)
      references MODUL (MD_ID);

alter table USER_KOMUNITAS
   add constraint FK_USER_KOM_REFERENCE_USER_1 foreign key (USR_ID)
      references USERS (USR_ID);

alter table USER_KOMUNITAS
   add constraint FK_USER_KOM_REFERENCE_KOMUNITA foreign key (KMT_ID)
      references KOMUNITAS (KMT_ID);

alter table USER_KOMUNITAS
   add constraint FK_USER_KOM_REFERENCE_USER_2 foreign key (ADM_USR_ID)
      references USERS (USR_ID);

alter table USER_MODUL
   add constraint FK_USER_MOD_REFERENCE_USER foreign key (USR_ID)
      references USERS (USR_ID);

alter table USER_MODUL
   add constraint FK_USER_MOD_REFERENCE_MODUL foreign key (MD_ID)
      references MODUL (MD_ID);
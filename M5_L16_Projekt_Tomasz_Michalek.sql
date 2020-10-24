

drop schema if exists expense_tracker cascade;

create schema if not exists expense_tracker 
---------------------------------------------------------------------------------

drop table if exists expense_tracker.users;

create table expense_tracker.users
            ( 
			id_user          serial primary key, 
			user_login       varchar(25) not null, 
			user_name        varchar(50) not null, 
			user_password    varchar(100) not null, 
			password_salt    varchar(100) not null, 
			active           boolean default true not null, 
			insert_date      timestamp default current_timestamp, 
			update_date      timestamp default current_timestamp
			);


drop table if exists expense_tracker.transaction_type;

create table expense_tracker.transaction_type
            ( 
			id_trans_type         serial primary key, 
			transaction_type_name varchar(50) not null, 
			active                boolean default true not null, 
			insert_date           timestamp default current_timestamp, 
			update_date           timestamp default current_timestamp
			);



drop table if exists expense_tracker.transaction_category;

create table expense_tracker.transaction_category
            ( 
			id_trans_cat         serial primary key, 
			category_name        varchar(50) not null, 
			category_description varchar(250), 
			active               boolean default true not null, 
			insert_date          timestamp default current_timestamp, 
			update_date          timestamp default current_timestamp
			);


drop table if exists expense_tracker.bank_account_owner;

create table expense_tracker.bank_account_owner
            ( 
			id_ba_own    serial primary key, 
			owner_name   varchar(50) not null, 
			user_login   integer not null, 
			active       boolean default true not null, 
			insert_date  timestamp default current_timestamp, 
			update_date  timestamp default current_timestamp
			);


drop table if exists expense_tracker.transaction_subcategory;

create table expense_tracker.transaction_subcategory
            (
			id_trans_subcat          serial primary key, 
			id_trans_cat             integer, 
			subcategory_name         varchar(50) not null, 
			subcategory_description  varchar(250), 
			active                   boolean default true not null, 
			insert_date              timestamp default current_timestamp, 
			update_date              timestamp default current_timestamp,
			foreign key (id_trans_cat) references 
			expense_tracker.transaction_category(id_trans_cat)
			);


drop table if exists expense_tracker.bank_account_types;

create table expense_tracker.bank_acount_types
            ( 
			id_ba_type        serial primary key, 
			ba_type           varchar(50)not null, 
			ba_desc           varchar(250), 
			active            boolean default true not null,
			is_common_account boolean default false not null, 
			id_ba_own         integer, insert_date timestamp default current_timestamp, 
			update_date       timestamp default current_timestamp,
			foreign key(id_ba_own) references 
			expense_tracker.bank_account_owner(id_ba_own)
			);


drop table if exists expense_tracker.transaction_bank_account;

create table expense_tracker.transaction_bank_account
            ( 
			id_trans_ba       serial primary key,
			id_ba_own         integer, 
			id_ba_type        integer, 
			bank_account_name varchar(50) not null, 
			ban_account_desc  varchar(250), 
			active            boolean default true not null, 
			insert_date       timestamp default current_timestamp, 
			update_date       timestamp default current_timestamp,
			foreign key(id_ba_own) references 
			expense_tracker.bank_account_owner(id_ba_own),
			foreign key(id_ba_type) references 
			expense_tracker.bank_acount_types(id_ba_type)
			);


drop table if exists expense_tracker.transactions;

create table expense_tracker.transactions
            ( 
			id_transaction    serial primary key, 
			id_trans_ba       integer, 
			id_trans_cat      integer, 
			id_trans_subcat   integer, 
			id_trans_type     integer, 
			id_user           integer, 
			transaction_date  date default current_date, 
			transaction_value numeric(9,2), 
			transaction_description text, 
			insert_date       timestamp default current_timestamp, 
			update_date       timestamp default current_timestamp,
			foreign key(id_trans_ba) references 
			expense_tracker.transaction_bank_account(id_trans_ba),
			foreign key(id_trans_cat) references 
			expense_tracker.transaction_category(id_trans_cat),
			foreign key(id_trans_subcat) references 
			expense_tracker.transaction_subcategory(id_trans_subcat),
			foreign key(id_trans_type) references 
			expense_tracker.transaction_type(id_trans_type),
			foreign key(id_user) references 
			expense_tracker.users(id_user)
			);


insert into expense_tracker.users (user_login, user_name, user_password, password_salt, active)
values ('tmichalek', 'Tomasz Michałek', md5('jjKSMgh456'||'ddd'), 'ddd', true);

insert into expense_tracker.transaction_type (transaction_type_name, transaction_type_desc, active)
values  ('PRZYCHOD', 'Wpływ na konto.', 1),
        ('ROZCHOD', 'Wydatek z konta.',1);
    
insert into expense_tracker.transaction_category (category_name, category_description, active)
values ('UBRANIA_DZIECIĘCE', 'Kategoria związana z wydatkami na ubrania ', 1);


insert into expense_tracker.bank_account_owner (owner_name, owner_desc, user_login, active)
values ('Tomasz Michałek', 'Konto osobiste PKO BP', 1, true );

insert into expense_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active)
values  (1, 'Ubrania do szkoły', 'Bluzy, koszuki, spodnie do szkoły',1),
        (1, 'Ubrania na zajecia sportowe', 'Strój sportowy na zajecia z koszykówki',1);
        
insert into expense_tracker.bank_account_types (ba_type, ba_desc, active, is_common_account, id_ba_own)
values ('ROR','Rachunek oszczędnościowo rozliczeniowy.', 1, 0, 1);

insert into expense_tracker.transaction_bank_account (id_ba_own, id_ba_typ, bank_account_name, bank_account_desc, active)
values (1, 1, 'Rachunek własny-Tomek', 'Konto prywatne', 1);

insert into expense_tracker.transactions (id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_date, transaction_value, transaction_description)
values (1,1,1,2,1,'24/10/2020',45.00,'Kupno spodni');

-----------------------------------------------------------------------------------------------
pg_dump --host localhost ^
        --port 5432 ^
        --username postgres ^
        --format plain ^
        --file "C:\Users\Tomasz Michalek\Desktop\sql_kurs\modul_5\modul5_dump_plain.sql" ^
        --clean ^
        postgres      
        
        
 psql -U postgres -p 5432 -h localhost -d postgres -f "C:\Users\Tomasz Michalek\Desktop\sql_kurs\modul_5\modul5_dump_plain.sql"



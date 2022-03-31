
create table if not exists Genre (
	id serial primary key,
	Genre varchar(40) unique not null
);

create table if not exists Artist (
	id serial primary key,
	Artist_name varchar(80) unique not null
);

create table if not exists Album (
	id serial primary key,
	Album_title varchar(80) unique not null,
	Release_year int not null
);

create table if not exists Collection (
	id serial primary key,
	Collection_title varchar(40) not null,
	Release_year int not null
);

create table if not exists Track (
	id serial primary key,
	Track_title varchar(80) not null,
	Track_duration int check(Track_duration > 0) not null,
	Album_id int references Album(id) not null
);

create table if not exists "genre/artist" (
	Genre_id int references Genre(id) not null,
	Artist_id int references Artist(id) not NULL,
	primary key(Artist_id, Genre_id)
);

create table if not exists "artist/album" (
	Artist_id int references Artist(id) not null,
	Album_id int references Album(id) not null,
	primary key(Artist_id, Album_id)
);

create table if not exists "collection/track" (
	Collection_id int references Collection(id) not null,
	Track_id int references Track(id) not null,
	primary key(Collection_id, Track_id)
);

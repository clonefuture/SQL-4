/*1.количество исполнителей в каждом жанре*/

select genre, count(artist_name) cnt_art
	from genre a join "genre/artist" b on a.id = b.genre_id
	join artist c on b.artist_id = c.id
group by genre
;


/*2.количество треков, вошедших в альбомы 2019-2020 годов*/

select count(track_title) cnt_track
	from track a join album b on a.album_id = b.id
	where b.release_year in (2019, 2020)
;


/*3.средн€€ продолжительность треков по каждому альбому*/

select album_title, round(avg(track_duration), 2) avg_dur_track
	from album a join track b on b.album_id = a.id
group by album_title
;


/*4.все исполнители, которые не выпустили альбомы в 2020 году*/

select distinct(artist_name) artist_name
	from artist 
	where artist_name not in
		(
		select artist_name
			from artist a join "artist/album" aa on a.id = artist_id 
			join album b on album_id = b.id 
			where release_year = 2020
		);


/*5.названи€ сборников, в которых присутствует конкретный исполнитель (’аски)*/	
	
select distinct (collection_title) collection_title
	from collection a join "collection/track" ct on a.id = ct.collection_id 
	join track t on ct.track_id = t.id 
	join album b on t.album_id = b.id 
	join "artist/album" aa on b.id = aa.album_id 
	join artist c on aa.artist_id = c.id 
	where c.artist_name = '’аски'
	;


/*6.название альбомов, в которых присутствуют исполнители более 1 жанра*/
	
select album_title 
	from album a join "artist/album" aa on aa.album_id = a.id 
	join artist a2 on a2.id = aa.artist_id 
	join "genre/artist" ga on ga.artist_id  = a2.id 
	group by album_title having count(ga.artist_id) > 1
	;
	

/*7.наименование треков, которые не вход€т в сборники*/
	
select track_title 
	from track t left join "collection/track" ct on t.id = ct.track_id 
	where ct.track_id is null
	;


/*8.исполнител€(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)*/
	
select artist_name  
	from track t join album a on t.album_id = a.id
	join "artist/album" aa on aa.album_id = a.id 
	join artist a2 on a2.id = aa.artist_id 
	where track_duration = (select min(track_duration) from track)
	;


/*9.название альбомов, содержащих наименьшее количество треков*/

select album_title  
	from track a join album b on album_id = b.id
	group by album_title 
	having count(a.id) = (
							select min(a.cnt)
							from (
								  select album_id, count(id) cnt 
								  from track group by album_id
								  ) a
						 )

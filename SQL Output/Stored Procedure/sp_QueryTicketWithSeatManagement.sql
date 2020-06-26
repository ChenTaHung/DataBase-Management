CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_QueryTicketWithSeatManagement`(
	in in_dep_time datetime,
    in in_dep_station int,
    in in_arr_station int,
    out num_row int(100)
)
BEGIN
	set @quot = NULL ;
	drop table if exists `ticketQuery` ;
	
	create temporary table ticketQuery as
	select 	a.train_id, 
			a.departure_station as departure_station,
			b.departure_station as arrival_station,
			timestamp(date(in_dep_time), a.departure_time) as departure_time, 
			timestamp(date(in_dep_time), b.arrival_time) as arrival_time, 
			abs(c.diff) * 100 as price
	from       (select train_id, departure_time,  departure_station from Train
				where departure_station = in_dep_station and 
					  departure_time is not null and
					  current_timestamp() > on_date and
					  (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) a 
	inner join (select train_id, arrival_time, departure_station from Train
				where departure_station = in_arr_station and 
					  arrival_time is not null and
					  current_timestamp() > on_date and
					  (current_timestamp() < off_date or off_date is null)
				order by train_id, arrival_time ) b
		on a.train_id = b.train_id 
	left join  (select station_id, location_marker - lag_marker as diff
				from (select *,@quot lag_marker, @quot:= location_marker curr_marker
					  from Station where station_id = in_dep_station or station_id = in_arr_station 
					  order by station_id) n
				where station_id = in_arr_station ) c
		on b.departure_station = c.station_id 
	having 		departure_time >= addtime(curtime(), "0 0:30:0") and 
				time(departure_time) >= CAST(in_dep_time as time) and 
		 		departure_time <= addtime(current_timestamp(), "13 0:0:0") ;
	/* Generate the table with train_id, dep/arr_station, dep/arr_time, price */
	   
	if  in_dep_station > in_arr_station then -- go north
        
		if  exists ( -- Tickets are booked
					select train_id, train_date, seat_id 
					from db_105408525.Ticket 
					where 	train_date >= current_timestamp() and 
							train_date >= in_dep_time and 
							in_arr_station < departure_station and 
							in_dep_station > arrival_station
					order by train_id, seat_id ) then
			
            /* generate the train that seat is not occupied */
            drop table if exists `seat_tbl` ;
			create temporary table seat_tbl as
			select distinct a.train_id, a.seat_id as seat_id
			from		(select distinct(Train.train_id), Seat.seat_id 
						 from db_105408525.Train, db_105408525.Seat                  
						 order by train_id, seat_id) a -- all trains with all seats
			left join 	(select train_id, train_date, seat_id 
						 from db_105408525.Ticket 
						 order by train_id, seat_id) b -- trains and seats that are booked
				on a.train_id = b.train_id  and a.seat_id = b.seat_id
				-- filter the train that will depart in future and the same date to input departure date
			where train_date is null 
			order by train_id, seat_id;
		
        else  -- no tickets are  booked
			drop table if exists seat_tbl ;
		
			create temporary table seat_tbl as
			select distinct(Train.train_id), Seat.seat_id 
						from db_105408525.Train, db_105408525.Seat 
						order by train_id, seat_id ;
        end if ;
	else -- go south
		if  exists ( -- Tickets are booked
					select train_id, train_date, seat_id 
					from db_105408525.Ticket 
					where 	train_date >= current_timestamp() and 
							train_date >= in_dep_time and 
							in_arr_station > departure_station and 
							in_dep_station < arrival_station
					order by train_id, seat_id ) then
            /* generate the train that seat is not occupied */
            drop table if exists `seat_tbl` ;
			create temporary table seat_tbl as
			select distinct a.train_id, a.seat_id as seat_id
			from		(select distinct(Train.train_id), Seat.seat_id 
						 from db_105408525.Train, db_105408525.Seat                  
						 order by train_id, seat_id) a -- all trains with all seats
			left join 	(select train_id, train_date, seat_id 
						 from db_105408525.Ticket 
						 order by train_id, seat_id) b -- trains and seats that are booked
				on a.train_id = b.train_id  and a.seat_id = b.seat_id
				-- filter the train that will depart in future and the same date to input departure date
			where train_date is null 
			order by train_id, seat_id;	
        else  -- no tickets are  booked
			drop table if exists seat_tbl ;
		
			create temporary table seat_tbl as
			select distinct(Train.train_id), Seat.seat_id 
						from db_105408525.Train, db_105408525.Seat 
						order by train_id, seat_id ;
		end if ;
    end if ;
	
    drop table if exists ticketQueryWithSeats ;
			
	create temporary table ticketQueryWithSeats as
	select 	a.train_id, a.departure_station, a.arrival_station, 
			b.seat_id, a.departure_time, a.arrival_time, a.price
	from ticketQuery a
	left join (select distinct * from seat_tbl) b
		on a.train_id = b.train_id
	where seat_id is not null 
	order by train_id, seat_id ; 
    
    select * from ticketQueryWithSeats ;
	set num_row = (select count(*) from ticketQueryWithSeats) ;
END
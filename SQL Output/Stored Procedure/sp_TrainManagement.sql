CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_TrainManagement`(
	in in_trainID int,
    in in_off_date date,
    in in_dep_time time, 
    in in_dep_station int,
    in in_arr_station int,
    in in_on_date date,
    out affected_row_num int(100)
)
BEGIN
	declare new_station_row_num int ;
    declare iter int default 1 ;
    declare new_train_id int ;
    declare previous_dep_time time ;
    declare need_time int ;
    
	-- Change old train.off_date to in_off_date
	update Train set off_date = in_off_date where train_id = in_trainID ;
    
    if in_dep_station > in_arr_station then -- go north
		set @quot = (select time_marker from Station where station_id = in_arr_station );
        -- Generate the Station table only contain in_dep_station and in_arr_station
        
        drop table if exists `go_north` ;
		create temporary table `go_north` as 
		select station_id, station_name ,@quot lag_marker, @quot:= time_marker curr_time_marker
		from Station where station_id >= in_arr_station and in_dep_station >= station_id 
		order by station_id ;
        
        drop table if exists `new_station` ;
        create temporary table new_station as 
        select station_id, station_name, curr_time_marker - lag_marker as marker_diff from go_north ;
	else -- go south
		set @quot = (select time_marker from Station where station_id = in_arr_station );
        -- Generate the Station table only contain in_dep_station and in_arr_station
        
        drop table if exists `go_south` ;
		create temporary table `go_south` as 
		select station_id, station_name ,@quot lag_marker, @quot:= time_marker curr_time_marker
		from Station where station_id >= in_dep_station and in_arr_station >= station_id 
		order by station_id desc;
        
        drop table if exists `new_station` ;
        create temporary table new_station as 
        select station_id, station_name, lag_marker - curr_time_marker as marker_diff from go_south;
 	
	end if ;
    /*
    drop table if exists `new_train` ;
	create table if not exists `new_train` (
	  `train_id` INT NOT NULL,
	  `arrival_time` TIME NULL,
	  `departure_time` TIME NULL,
	  `departure_station` INT NOT NULL,
	  `off_date` DATETIME NULL,
	  `on_date` DATETIME NULL,
	  PRIMARY KEY (`train_id`, `departure_station`),
	  INDEX `train_2_station_idx` (`departure_station` ASC))
	ENGINE = InnoDB;
    */
    set new_station_row_num = (select count(*) from new_station) ; -- Total Station that the new train will go through
    set new_train_id = (select max(train_id) from Train limit 1 ) + 1; -- The next train_id
    
    while iter <= new_station_row_num do
		if in_dep_station > in_arr_station then-- go north
			if iter = 1 then -- the departure station information 
				insert into Train
					values(new_train_id, null, in_dep_time, in_dep_station, null, in_on_date) ; 
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station ) ;
                set iter = iter + 1 ;
			elseif iter > 1 and iter < new_station_row_num then -- stations passed
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, previous_dep_time + interval need_time + 2 minute,
							in_dep_station - (iter - 1), null, in_on_date ) ;
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station - (iter - 1)) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station - (iter - 1) ) ;
				set iter = iter + 1 ;
			elseif iter = new_station_row_num then -- arrival_station
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, null,
							in_arr_station, null, in_on_date ) ;
				set iter = iter + 1 ;
			end if ;
		else -- go south
			if iter = 1 then -- the departure station information 
				insert into Train
					values(new_train_id, null, in_dep_time, in_dep_station, null, in_on_date) ; 
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station  ) ;
                set iter = iter + 1 ;
			elseif iter > 1 and iter < new_station_row_num then -- stations passed
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, previous_dep_time + interval need_time + 2 minute,
							in_dep_station + (iter - 1), null, in_on_date ) ;
				set previous_dep_time = (select departure_time from Train where train_id = new_train_id and departure_station = in_dep_station + (iter - 1)) ;
				set need_time = (select marker_diff from new_station where station_id = in_dep_station + (iter - 1)) ;
				set iter = iter + 1 ;
			elseif iter = new_station_row_num then
				insert into Train
					values(	new_train_id, previous_dep_time + interval need_time minute, null,
							in_arr_station, null, in_on_date ) ;
                set iter = iter + 1 ;
			end if ;
		end if ;
	end while ;
    
    set affected_row_num = (select count(*) from Train where train_id = new_train_id ) + -- new train 
						   (select count(*) from Train where train_id = in_trainID) ; -- old train
    
	select 	a.train_id, 
			a.departure_time,
            b.arrival_time,
			a.departure_station as departure_station,
			b.departure_station as arrival_station,
            a.on_date,
            a.off_date
	from       (select train_id, departure_time,  departure_station, on_date, off_date from Train
				where departure_station = in_dep_station and 
					  departure_time is not null
				order by train_id, arrival_time ) a 
	inner join (select train_id, arrival_time, departure_station from Train
				where departure_station = in_arr_station and 
					  arrival_time is not null
				order by train_id, arrival_time ) b
		on a.train_id = b.train_id 
	having train_id = new_train_id;
        
        
END
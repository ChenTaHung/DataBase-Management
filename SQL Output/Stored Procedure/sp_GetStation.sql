CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_GetStation`(
	out num_of_row int
)
BEGIN
	select station_id as station_id, station_name as station_name 
    from db_105408525.Station 
    order by station_id ;
    
    set num_of_row = (select count(*) from db_105408525.Station) ;
END
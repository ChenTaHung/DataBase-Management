CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_GetBookTicketByUser`(
	in in_userID int,
    out num_row int(100)
)
BEGIN
	drop table if exists `result_set` ;
    
	create temporary table result_set as
    select ticket_id, user_id, train_id, seat_id, book_time
    from Ticket
    where user_id = in_userID and pay_time is null;
    
    select * from result_set ;
    
    set num_row = (select count(*) from result_set)  ;
    
END
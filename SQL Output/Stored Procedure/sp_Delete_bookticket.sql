CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_Delete_bookticket`(
	in in_userID int, 
    in in_ticketID int,
    out affected_row_num int(100),
    out message varchar(100)
)
BEGIN

    if exists (	select * from Ticket 
				where user_id = in_userID and ticket_id = in_ticketID and pay_time is null) then
    
		set @before_n = (select count(*) from Ticket 
						 where user_id = in_userID and ticket_id = in_ticketId and pay_time is null ) ;
		delete from Ticket where ticket_id = in_ticketID and user_id = in_userID and pay_time is null ;
        set @after_n = (select count(*) from Ticket
						where user_id = in_userID and ticket_id = in_ticketId and pay_time is null ) ;
                        
		set affected_row_num = @before_n - @after_n ;
        set message = "The selected unpaid ticket has been deleted." ; 
	elseif exists (select * from Ticket 
					where user_id = in_userID and ticket_id = in_ticketID and pay_time is not null) then
		set affected_row_num = 0 ;
        set message = "Tickets were paid, cannot be deleted." ; 
	else 
		set affected_row_num = 0 ;
        set message = "No Tickets were booked or tickets cannot be deleted." ;
        
	end if ;
END
CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_PayTicket`(
	in in_userID int,
    in in_ticketID int,
    out affected_row_num int,
    out message varchar(200)
)
BEGIN
	declare currentTime time ;
    declare before_n int ;
    declare after_n int ;
    
    set currentTime = current_timestamp()  ;	
    
	if exists ( -- Tickets that are booked but haven't been paid within 3 days
				select * from Ticket 
				where user_id = in_userID and 
					  in_ticketID and
					  pay_time is null and
					  currentTime >= addtime(book_time, "3 0:0:0")) then 
                      -- payment must be done in 3 days
                      
        -- Count rows before delete               
		set before_n  = (select count(*) 
						 from Ticket 
						 where user_id = in_userID and 
                         ticket_id = in_ticketID and
						 pay_time is null and
						 currentTime >= addtime(book_time, "3 0:0:0")) ;
         
		delete from Ticket 
			where user_id = in_userID and 
				  ticket_id = in_ticketID and
				  pay_time is null and
				  currentTime > addtime(book_time, "3 0:0:0") ;
        -- Count rows after delete           
		set after_n = (select count(*) 
					   from Ticket 
					   where user_id = in_userID and 
                       ticket_id = in_ticketID and
					   pay_time is null and
					   currentTime >= addtime(book_time, "3 0:0:0")); 
        
		set message = (select "Tickets were deleted because of not being paid within three days" ) ;
        set affected_row_num = before_n - after_n ; 
        
	elseif not exists ( -- no unpaid tickets
						 select * from Ticket 
						 where user_id = in_userID and 
                         ticket_id = in_ticketID and
						 pay_time is null and
                         currentTime <= addtime(book_time, "3 0:0:0")) then
		set message = (select "No Tickets need to pay" ) ;
        set affected_row_num  = ( select 0 );
	else 
		update Ticket set pay_time = currentTime 
			where user_id = in_userID and 
				  ticket_id = in_ticketID and
				  pay_time is null;
                  
		set message = (select "Tickets have been paid") ;
        
        set affected_row_num = (select count(*) from Ticket
								where user_id = in_userID and 
								ticket_id = in_ticketID and
								pay_time = currentTime );
    end if ;
    
    select	a.ticket_id, a.user_id, a.train_id, 
			a.departure_station, a.arrival_station, 
            a.seat_id, a.book_time, a.train_date as departure_time, 
            timestamp(date(a.train_date), time(b.arrival_time)) as arrival_time, 
            a.price, a.pay_time
    from Ticket a
	left join Train b 
		on 	a.train_id = b.train_id and 
            a.arrival_station = b.departure_station
	where ticket_id = in_ticketID and user_id = in_userID ;
		
    
END
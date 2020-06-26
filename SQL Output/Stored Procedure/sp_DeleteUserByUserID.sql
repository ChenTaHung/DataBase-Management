CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_DeleteUserByUserID`(
	in in_userID int(10),
    out affected_row_num int(100),
    out message varchar(100)
)
BEGIN
	if exists (select * from Ticket 
			   where user_id = in_userID and pay_time is null) then 
               -- User exists and the tickets are not paid
	   set message = (select "Cannot delete user due to unpaid tickets") ;
       set affected_row_num = 0 ;
	 else  
		-- Update User table 
		update User set isDelete = 1 where user_id = in_userID ;
        
        -- Update UserCredential table
		update UserCredential set isDelete = 1 where user_id = in_userID;
        
        set message = (select "User deleted!") ;
        set affected_row_num = (select count(*) from User where user_id = in_userID and isDelete = 1);
	
   end if ;     
END
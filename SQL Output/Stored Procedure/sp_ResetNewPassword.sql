CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_ResetNewPassword`(
	in in_userID int(10),
    in in_salt char(255),
    in in_hashedPwd char(255),
    out affected_row_num int(100),
    out message varchar(200)
)
BEGIN
    -- If password doesn't change: do nothing
	if exists ( select * from UserCredential where hashedPwd = in_hashedPwd) then
		select affected_row_num = 0 ;
        set message = (select "Password unchanged, please choose a different password." ) ;
	-- If user not exists: do nothing
	elseif not exists( select * from User where user_id = in_userID ) then
		select affected_row_num = 0 ;
        set message = (select "User Not Found!");
	else 
		update User 
			set salt = in_salt 
            where user_id = in_userID ;
            
		update UserCredential 
			set hashedPwd = in_hashedPwd,
				createDateTime = current_timestamp() 
			where user_id = in_userID ;
		set affected_row_num = (select count(*) from User where user_id = in_userID) ;
        set message = (select "Password Changed") ;
	end if ;
    
	
END
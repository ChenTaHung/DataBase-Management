CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_RegisterUser`(
    in in_email varchar(100),
    in in_firstname varchar(100),
    in in_lastname varchar(100),
    in in_Dob date,
    in in_salt char(255),
    in in_hashedPwd char(255),
    out row_num int(100) 
)
BEGIN
	declare new_userID int(10) ;
    declare new_user_register_time datetime ;
    
	if exists(select user_id from User where email = in_email) THEN
		select 1;
	else
		insert into User 
			values(NULL, in_email, in_firstname, in_lastname, in_Dob,
					in_salt, current_timestamp(), NULL) ;
	end if;       
    
	if exists (select * from User where email = in_email) then
		set @new_userID = (select user_id from User where email = in_email ) ;
        set @new_user_register_time = (select registerDateTime from User where email = in_email) ;
        
        insert into UserCredential 
			values(Null, @new_userID,  in_hashedPwd, @new_user_register_time) ; 
	else
		select 1 ;
	
    end if ;

    set row_num = (select _user_id from User where email = in_email) ;
	
    
    
	-- select @affected_row_num := count(*) as affected_row_num from User where email = in_email ;
END
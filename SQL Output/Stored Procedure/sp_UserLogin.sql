CREATE DEFINER=`105408525`@`192.168.56.1` PROCEDURE `sp_UserLogin`(
	in in_email varchar(200),
    in in_hashedPwd char(200),
    out row_num int(100),
    out login_status varchar(100)
)
BEGIN
	if exists (select *, b.hashedPwd
			   from User a left join UserCredential b 
			   on a.user_id = b.user_id
			   where email = in_email and hashedPwd = in_hashedPwd) then
		set row_num = (select count(*) 
					   from User a left join UserCredential b 
                       on a.user_id = b.user_id
					   where email = in_email and hashedPwd = in_hashedPwd ); 
		set login_status = (select "Login Succesfully");
	else 
		set login_status = (select "Nonexistent E-mail or invalid password") ;
	end if ;
END
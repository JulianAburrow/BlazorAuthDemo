Run the BlazorAuthDemoDbScript to create the tables necessary to use this application.

See this video for details of how authentication can be added to an application from scratch without using the scaffolding method.

https://www.youtube.com/watch?v=LBByZRhyZ8U&

The 'Areas' folder is completely new so does not have the above commented text. This folder and its subfolders contain the register, login and logout UI and code

Once you have created a user for yourself I strongly suggest creating a role called SuperAdmin in AspNetRoles. When you have done this, add the id of the role and the id of your user
to the AspNetUserRoles table. This will enable you to use the

<AuthorizeView Roles="YourRoleName">

markup to show how parts of the application can be made available only to certain roles.

As an example, note that in NavMenu the whole menu structure is only available to a user in the role 'SuperAdmin'.

If you expereince difficulties running the application due to https certificates etc this page:

https://stackoverflow.com/questions/70291876/how-to-force-visual-studio-to-re-create-the-ssl-certificate-for-a-net-core-web

will hopefully solve the problem. Ensure that you close any console windows before running these scripts.

This might bhe handy to create some roles:

INSERT INTO security.AspNetRoles (
	Id, Name, NormalizedName
) VALUES
	( NEWID(), 'SuperAdmin', 'SUPERADMIN' ),
	( NEWID(), 'User', 'USER' ),
	( NEWID(), 'Admin', 'ADMIN' )

This will put a user into a role:

INSERT INTO security.AspNetUserRoles (
	UserId, RoleId
) VALUES (
	(SELECT Id FROM security.AspNetUsers WHERE UserName = 'a@b.com'), (SELECT Id FROM security.AspNetRoles WHERE Name = 'SuperAdmin')


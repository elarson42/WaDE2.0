Alter Table Core.Sites_dim add StateCV Nvarchar (50) NULL

EXEC sp_rename 'Core.Sites_dim.SiteUUID', 'WaDESiteUUID', 'COLUMN'




Alter Table Core.Sites_dim add StateCV Nvarchar (2) NULL

ALTER TABLE Core.Sites_dim
ADD CONSTRAINT FK_Sites_dim_StateCV
FOREIGN KEY (StateCV)
REFERENCES CVs.State(Name)

EXEC sp_rename 'Core.Sites_dim.SiteUUID', 'WaDESiteUUID', 'COLUMN'




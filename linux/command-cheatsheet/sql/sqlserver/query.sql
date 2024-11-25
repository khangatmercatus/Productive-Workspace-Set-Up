-- Database size
with fs
as
(
    select database_id, type, size * 8.0 / 1024 size
    from sys.master_files
)
select 
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
from sys.databases db
where name like 'Stg-BigY%'

-- Show connections (Psid/Who/database)
SP_WHO ;

-- Terminate connection
KILL <PSID> where dbname like 'Stg-BigY%';

-- List all file (data + log) partition for a backup (.bak) file
RESTORE FILELISTONLY FROM DISK = 'D:\SQLBackup\BigYProduction\BigYv6-DistributionCore\backup-20241115-114905.bak' 

-- Change data/log file name
ALTER DATABASE my_renamed_db SET OFFLINE;
ALTER DATABASE my_renamed_db MODIFY FILE (NAME='data_file_name', FILENAME='d:\dbs\data\my_renamed_db.mdf');
ALTER DATABASE my_renamed_db MODIFY FILE (NAME='log_file_name', FILENAME='d:\dbs\data\my_renamed_db.ldf');
ALTER DATABASE my_renamed_db SET ONLINE;



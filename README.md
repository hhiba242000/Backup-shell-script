# Shell BackUp Script

## Table of content

- [Description](#description)
- [Prerequisites](#prerequisites)
- [Files Hierarchy](file_hierarchy)
- [Usage Manual](#usage_manual)
- [Cron Jobs](#cron_jobs)

## Description

This is a shell script, when run it creates a number of backups from a specific directory you choose. The script can run every interval of time or it could be run as a cron jon

## Prerequisites

As prerequisites, you will need to `make` command utility installed. If you run the script as a cron job you need to make sure you have
permission to use cron
```bash
sudo apt install -y make
```
the script uses familiar shell commands eg. `mkdir`,`touch`,`echo`

## File Hierarchy

`createdir.sh`: file where the shell script of creating needed directory to place backups resides
`backupd.sh`: file where the shell script of backing up resides
`backup_cron.sh`: file where the shell script of backing up resides, should be used when using `cron jobs`
`Makefile`: make file that is used to link the `backupd.sh` and `createdir.sh`

## Usage Manual

After downloading the script, you use the following command from the terminal to run it
```bash
make dir_full_path=<relative_path> backupdir=<relative_path> sleep_interval=<time_in_millisconds> max_backups=<positive_integer
```
`dir_full_path`: the source directory that have list of file we need to backup.
`backupdir`: the destination directory that will have the backup
`sleep_interval`: time to wait between every check
`max_backups`: maximum number of backups need to be reserved

Make sure the passed paths in the arguemts are relative to your current directory, also to run this command you should be on the same directory as the makefile otherwise you need to specify directory of Makefile using `-f <path>` or `--file=path`


## Cron Job

To run it as a cron job you will use the `backup_cron.sh` file. First you need to open editor for cron using the following command.

```bash
crontab -e
```
Then you add the cron job in the cron jobs file and save it

```bash
*   *   *   *   *  sh /path/to/script/script.sh
|   |   |   |   |              |
|   |   |   |   |      Command or Script to Execute        
|   |   |   |   |
|   |   |   |   |
|   |   |   |   |
|   |   |   | Day of the Week(0-6)
|   |   |   |
|   |   | Month of the Year(1-12)
|   |   |
|   | Day of the Month(1-31)  
|   |
| Hour(0-23)  
|
Min(0-59)
```

**NB** In case you are not allowed to use cron, you should add your name to the list of allowed users. This may differ according to your OS

Don't forget to make your script executable using this command 
```bash

chmod 775 <script_path>

```
Then use this line to make the cronjob run once every one minute.

```bash

*/1 * * * * /bin/sh <full_path_to_script> <full_path_to_directory> <full_path_to_backup_dir> <sleep_interval> <max_backups>

```
.PHONY = all
#n terms of Make, a phony target is simply a target that is always out-of-date, so whenever you ask make <phony_target>,
# it will run, independent from the state of the file system

SCRIPTFILE = ./createdir.sh ./backupd.sh 

all: generate backup


generate:
	@bash createdir.sh  $(backupdir)

backup: generate
	@bash backupd.sh  $(dir_full_path) $(backupdir) $(sleep_interval) $(max_backups)

clean:
	@find $(backupdir) -name "20*" | xargs rm -r
#xargs [OPTION]... COMMAND [INITIAL-ARGS]...
#Run COMMAND with arguments INITIAL-ARGS and more arguments read from input
	@rm  $(backupdir)/logfile.last $(backupdir)/logfile.new
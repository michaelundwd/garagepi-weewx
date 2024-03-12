#!/bin/bash
######################################################################
#   Backups to DESTINATION_FOLDER / Zips and performs basic rotation #
#   Derived from backup_rotate.sh with fixed (no) parameters         #
#   Handles the weewx folder and archive seperately                  #
######################################################################

SOURCE_FOLDER="/source/" # source folder
DESTINATION_FOLDER="/backup/" # mounted folder
BASENAME="basename $SOURCE_FOLDER"
ROTATE_PERIOD=10

# datestamp has a formatted date
datestamp=`date +"%Y-%m-%d"`
#   was datestamp=`date +"%d-%m-%Y"`
#### Display command usage ########
usage()
{
cat << EOF
USAGE:
backup_rotate.sh [OPTIONS] /source_folder/ /destination_folder/

Back up and entire folder, creates tgz and ,
performs x day rotation of backups Must provide source anddestination folders

OPTIONS:
-p Specify Rotation period in days - default is $ROTATE_PERIOD

EXAMPLES:
backup_rotate.sh -p 5 [/source_folder/] [/destination_folder/]

EOF
}

#### Getopts #####
#   while getopts ":p:" opt; do
#   case "$opt" in
#   p) ROTATE_PERIOD=${OPTARG};;

#   \?) echo "$OPTARG is an unknown option"
#   usage
#   exit 1
#   ;;
#   esac
#   done

#   shift $((OPTIND-1))

#   if [ -z "$1" ] || [ -z "$2" ]; then
#   usage
#   else

#   Force mounting of backup folder in case it has not been done already
sudo mount /mnt/backup

#  Backup and gzip the weewx directory
SOURCE_FOLDER="/home/weewx"
BASENAME=`basename "$SOURCE_FOLDER"`
TGZFILE="$BASENAME-$datestamp.tgz"
LATEST_FILE="$BASENAME-Latest.tgz"
DESTINATION_FOLDER="/mnt/backup/weewx"
ARCHIVE_FOLDER="/home/weewx/archive"
echo "Starting weewx Backup and Rotate to $TGZFILE "
#   was echo "\nStarting weewx Backup and Rotate to $TGZFILE "
#   echo "\n-----------------------------"
#   echo "\nSource Folder : $SOURCE_FOLDER"
#   echo "\nTarget Folder : $DESTINATION_FOLDER"
#   echo "\nBackup file : $TGZFILE "
#   echo "\n-----------------------------"

if [ ! -d "$SOURCE_FOLDER" ] || [ ! -d "$DESTINATION_FOLDER" ] || [ ! -d "$ARCHIVE_FOLDER" ] ; then
echo "SOURCE ($SOURCE_FOLDER) or DESTINATION ($DESTINATION_FOLDER) OR ARCHIVE ($ARCHIVE_FOLDER) folder doesn't exist/ or is misspelled, check & re-try."
exit 0;
fi

#   echo "\nCreating $SOURCE_FOLDER/$TGZFILE ... "
tar --exclude=$ARCHIVE_FOLDER --exclude=$SOURCE_FOLDER/$TGZFILE -zcf $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER
#   tar zcf $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER
#   was tar zvcf $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER
#   echo "\nCopying $SOURCE_FOLDER/$TGZFILE to $LATEST_FILE ... "
#   cp $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER/$LATEST_FILE

echo "Moving $TGZFILE -- to --> $DESTINATION_FOLDER "
#   was echo "\nMoving $TGZFILE -- to --> $DESTINATION_FOLDER "
cp $SOURCE_FOLDER/$TGZFILE $DESTINATION_FOLDER
rm $SOURCE_FOLDER/$TGZFILE
#   was mv $SOURCE_FOLDER/$TGZFILE $DESTINATION_FOLDER

#   echo "\nMoving $LATEST_FILE -- to --> $DESTINATION_FOLDER "
#   mv $SOURCE_FOLDER/$LATEST_FILE $DESTINATION_FOLDER
# count the number of file(s) in the appropriate folder Rotate the logs, delete older than
# ROTATE_PERIOD days, if their are at_least 7 backups

FILE_COUNT=`find $DESTINATION_FOLDER -maxdepth 1 -type f | wc -l`
#   echo "\n Rotation period $ROTATE_PERIOD for $DESTINATION_FOLDER "
#   echo "\n $FILE_COUNT files found in $DESTINATION_FOLDER folder"
#   echo "\n find $DESTINATION_FOLDER -mtime +$ROTATE_PERIOD"
#   echo "\n -----------------------------------"
if [ $FILE_COUNT -gt $ROTATE_PERIOD ]; then
#   echo "Removing backups older than $ROTATE_PERIOD in $DESTINATION_FOLDER"
#   echo "Removing these old backup files..."
find $DESTINATION_FOLDER -mtime +$ROTATE_PERIOD -exec rm {} \;
#   else
#   echo "Only $FILE_COUNT file, NOT removing older backups in $DESTINATION_FOLDER "
fi
#   fi

#  Backup and gzip the archive directory
SOURCE_FOLDER="/home/weewx/archive"
BASENAME=`basename "$SOURCE_FOLDER"`
TGZFILE="$BASENAME-$datestamp.tgz"
LATEST_FILE="$BASENAME-Latest.tgz"
DESTINATION_FOLDER="/mnt/backup/weewx_archive"
echo "Starting archive Backup and Rotate to $TGZFILE "
#   was echo "\nStarting archive Backup and Rotate "
#   echo "\n-----------------------------"
#   echo "\nSource Folder : $SOURCE_FOLDER"
#   echo "\nTarget Folder : $DESTINATION_FOLDER"
#   echo "\nBackup file : $TGZFILE "
#   echo "\n-----------------------------"

if [ ! -d "$SOURCE_FOLDER" ] || [ ! -d "$DESTINATION_FOLDER" ] ; then
echo "SOURCE ($SOURCE_FOLDER) or DESTINATION ($DESTINATION_FOLDER) folder doesn't exist/ or is misspelled, check & re-try."
exit 0;
fi

#   echo "\nCreating $SOURCE_FOLDER/$TGZFILE ... "
#   tar --exclude=$EXCLUSION_FOLDER -zcf $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER
tar --exclude=$SOURCE_FOLDER/$TGZFILE -zcf $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER
#   was tar zvcf $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER
#   echo "\nCopying $SOURCE_FOLDER/$TGZFILE to $LATEST_FILE ... "
#   cp $SOURCE_FOLDER/$TGZFILE $SOURCE_FOLDER/$LATEST_FILE

echo "Moving $TGZFILE -- to --> $DESTINATION_FOLDER "
#   was echo "\nMoving $TGZFILE -- to --> $DESTINATION_FOLDER "
cp $SOURCE_FOLDER/$TGZFILE $DESTINATION_FOLDER
rm $SOURCE_FOLDER/$TGZFILE
#   was mv $SOURCE_FOLDER/$TGZFILE $DESTINATION_FOLDER

#   was echo "\nMoving $LATEST_FILE -- to --> $DESTINATION_FOLDER "
#   mv $SOURCE_FOLDER/$LATEST_FILE $DESTINATION_FOLDER
# count the number of file(s) in the appropriate folder Rotate the logs, delete older than
# ROTATE_PERIOD days, if their are at_least 7 backups

FILE_COUNT=`find $DESTINATION_FOLDER -maxdepth 1 -type f | wc -l`
#   echo "\n Rotation period $ROTATE_PERIOD for $DESTINATION_FOLDER "
#   echo "\n $FILE_COUNT files found in $DESTINATION_FOLDER folder"
#   echo "\n find $DESTINATION_FOLDER -mtime +$ROTATE_PERIOD"
#   echo "\n -----------------------------------"
if [ $FILE_COUNT -gt $ROTATE_PERIOD ]; then
#   echo "Removing backups older than $ROTATE_PERIOD in $DESTINATION_FOLDER"
#   echo "Removing these old backup files..."
find $DESTINATION_FOLDER -mtime +$ROTATE_PERIOD -exec rm {} \;
#   else
#   echo "Only $FILE_COUNT file, NOT removing older backups in $DESTINATION_FOLDER "
fi
#   fi

#   echo "----------------"
echo "$datestamp backup of weewx and archive completed"
#   echo "to extract file >> tar -xzvf $TGZFILE "

 

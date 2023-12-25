#!/bin/sh

#PROGRAM="REAP and MPT";

echo;
echo "starting installation... please wait"
echo "===============================================";
echo;

echo "Extracting archive...";

# create a temp directory to extract to.
export WRKDIR=`mktemp -d /tmp/selfextract.XXXXXX`

SKIP=`awk '/^__ARCHIVE_FOLLOWS__/ { print NR + 1; exit 0; }' $0`

# Take the TGZ portion of this file and pipe it to tar.
tail -n +$SKIP $0 | tar xz -C $WRKDIR

echo "...done.";
echo;

# execute the installation script

echo "Executing installation script...";
echo "--------------------------------";
echo;
PREV=`pwd`
cd $WRKDIR/REAP_MPTInstall

./install.sh $PREV

#echo "Copying Documentation to current directory";
#cp -a $WRKDIR/REAP_MPT/Doc/* $PREV
echo;
echo "--------------------------------";
echo "...done.";

# delete the temp files
cd $PREV
rm -rf $WRKDIR

echo;
echo "Installation is finished.";
echo;

exit 0

__ARCHIVE_FOLLOWS__

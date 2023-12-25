#!/usr/bin/sh

version=`cat RGEVersion`
MPTversion=1.1
FILES="REAP-${version}.installer.sh REAP-${version}.tar.gz REAP-Documentation-${version}.pdf REAP_incl_MPT-${version}.installer.sh REAP_incl_MPT-${version}.tar.gz REAP-UserGuide-${version}.pdf MPT-${MPTversion}.installer.sh MPT-${MPTversion}.tar.gz MPT-Documentation-${MPTversion}.pdf"

scp $FILES hepforge:/hepforge/home/reapmpt/downloads

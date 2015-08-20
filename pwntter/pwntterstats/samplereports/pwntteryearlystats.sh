#!/bin/sh
#
# A yearly stats report that reports the year preceding the current
# year.  This example writes an html file to /var/www/stats
#
# intended to be run from cron like this:
#
# m h  dom mon dow   command
#0 1 1 1 * /usr/local/bin/pwntteryearlystats.sh

FROM=$(date --date "last year" +%Y0101)
TO=$(date --date "last year" +%Y1231)
TITLE=$(date --date "last year" +"%Y")
ODIR=/srv/http/IMIT_files
FILE=$(date --date "last year" +%Y)

/usr/local/bin/pwntterstats --from $FROM --to $TO \
	--title "pwntter stats report for $TITLE" \
	--html \
	--stopwords "/usr/local/bin/stopwords.txt" \
	--output "$ODIR/$FILE.html"

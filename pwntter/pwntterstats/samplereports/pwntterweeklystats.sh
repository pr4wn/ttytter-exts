#!/bin/sh
#
# A weekly stats report that reports the week preceding the current
# week.  This example writes an html file to /var/www/stats
#
# intended to be run from cron like this:
#
# m h  dom mon dow   command
#0 1 * * 0 /usr/local/bin/pwntterweeklystats.sh

FROM=$(date --date "7 days ago" +%Y%m%d)
TO=$(date --date "yesterday" +%Y%m%d)
TITLE="last week"
ODIR=/srv/http/IMIT_files
FILE="lastweek"

/usr/local/bin/pwntterstats --from $FROM --to $TO \
	--title "pwntter stats report for $TITLE" \
	--html \
	--stopwords "/usr/local/bin/stopwords.txt" \
	--output "$ODIR/$FILE.html"

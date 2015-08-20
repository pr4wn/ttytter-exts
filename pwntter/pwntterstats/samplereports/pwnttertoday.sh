#!/bin/sh
#
# A daily stats report that reports yesterday's stats.
# This example writes an html file to /var/www/stats
#
# intended to be run from cron like this:
#
# m h  dom mon dow   command
#0 1 * * * /usr/local/bin/pwntterdailystats.sh

FROM=$(date --date "today" +%Y%m%d)
TO=$(date --date "today" +%Y%m%d)
TITLE="today"
ODIR=/var/www/stats
FILE="today"

/usr/local/bin/pwntterstats --from $FROM --to $TO \
	--title "pwntter stats report for $TITLE" \
	--html \
	--output "$ODIR/$FILE.html"

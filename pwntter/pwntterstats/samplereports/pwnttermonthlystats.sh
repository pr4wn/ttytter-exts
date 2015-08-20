#!/bin/sh
#
# A monthly stats report that reports the month preceding the current
# month.  This example writes an html file to /var/www/stats
#
# intended to be run from cron like this:
# m h  dom mon dow   command
#0 1 1 * * /usr/local/bin/pwnttermonthlystats.sh

FROM=$(date --date "last month" +%Y%m01)
TO=$(date --date "`date +%m/01/%Y` yesterday" +%Y%m%d)
TITLE=$(date --date "last month" +"%B %Y")
ODIR=/srv/http/IMIT_files
FILE=$(date --date "last month" +%Y%m)

/usr/local/bin/pwntterstats --from $FROM --to $TO \
	--title "pwntter stats report for pr4wn's feed for $TITLE" \
	--html \
	--stopwords "/usr/local/bin/stopwords.txt" \
	--output "$ODIR/$FILE.html"

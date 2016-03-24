import datetime
import sys

try:
    interval_in_minutes = int(sys.argv[1])
except (IndexError, ValueError):
    interval_in_minutes = 60
timestamp1 = datetime.datetime.now()
timestamp2 = timestamp1 + datetime.timedelta(minutes=interval_in_minutes)
timestamp_format = '%Y%m%d-%H%M'
print('%s - %s' % (
    timestamp1.strftime(timestamp_format),
    timestamp2.strftime(timestamp_format)))

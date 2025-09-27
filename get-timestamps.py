#!/usr/bin/env python
'''
sudo dnf -y install xsel
pip install --user pyperclip
'''
from argparse import ArgumentParser
from datetime import datetime, timedelta


def get_timestamps(date, time, interval_in_minutes):
    start_datetime = datetime.now()
    if date:
        start_datetime = start_datetime.replace(
            year=date.year, month=date.month, day=date.day)
    if time:
        start_datetime = start_datetime.replace(
            hour=time.hour, minute=time.minute)
    old_minute_count = start_datetime.minute
    new_minute_count = int(round(
        old_minute_count / MINUTE_COUNT)) * MINUTE_COUNT

    timestamp1 = start_datetime + timedelta(minutes=(
        new_minute_count - old_minute_count))
    timestamp2 = timestamp1 + timedelta(minutes=interval_in_minutes)
    return timestamp1, timestamp2


MINUTE_COUNT = 30


if __name__ == '__main__':
    argument_parser = ArgumentParser()
    argument_parser.add_argument(
        '-d', '--date',
        type=lambda _: datetime.strptime(_, '%Y%m%d'))
    argument_parser.add_argument(
        '-t', '--time',
        type=lambda _: datetime.strptime(_, '%H%M'))
    argument_parser.add_argument(
        '-i', '--interval_in_minutes', type=int, default=60)
    args = argument_parser.parse_args()

    timestamp1, timestamp2 = get_timestamps(
        args.date, args.time, args.interval_in_minutes)
    timestamp_format = '%Y%m%d-%H%M'
    timestamp_text = '%s %s - %s: %s minutes' % (
        timestamp1.strftime('%A'),
        timestamp1.strftime(timestamp_format),
        timestamp2.strftime(timestamp_format),
        args.interval_in_minutes)
    print(timestamp_text)
    try:
        import pyperclip
        pyperclip.copy(timestamp_text)
    except Exception:
        pass

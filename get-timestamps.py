#!/usr/bin/env python
'''
sudo dnf -y install xsel
pip install --user pyperclip
'''
from argparse import ArgumentParser
from datetime import datetime, timedelta


def get_timestamps(interval_in_minutes):
    now = datetime.now()
    old_minute_count = now.minute
    new_minute_count = int(round(old_minute_count / 15.)) * 15

    timestamp1 = now + timedelta(minutes=(new_minute_count - old_minute_count))
    timestamp2 = timestamp1 + timedelta(minutes=interval_in_minutes)
    return timestamp1, timestamp2


if __name__ == '__main__':
    argument_parser = ArgumentParser()
    argument_parser.add_argument(
        'interval_in_minutes', nargs='?', type=int, default=30)
    args = argument_parser.parse_args()

    timestamp1, timestamp2 = get_timestamps(args.interval_in_minutes)
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

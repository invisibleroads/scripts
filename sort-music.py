#!/bin/env python
"Arrange music in a YYYY/MM file structure."
import re
import sys
from collections import defaultdict
from datetime import datetime
from invisibleroads_macros.disk import make_folder
from invisibleroads_macros.log import format_path
from os import walk
from os.path import (
    basename, dirname, exists, getmtime, getsize, join, realpath, relpath,
    splitext)
from shutil import copy2


BRACKET_PREFIX_PATTERN = re.compile(r'^\[.*?\]-')


class Progress(object):

    template = '%s/%s %s %s'
    file_count = 0
    count_by_message = defaultdict(int)

    def show(self, file_index, message, target_path):
        print(self.template % (
            file_index, self.file_count, message,
            format_path(relpath(target_path, target_folder))))
        self.count_by_message[message] += 1


class DuplicateError(Exception):
    pass


def sort_music(source_folder, target_folder):
    progress = Progress()
    for root_folder, folder_names, file_names in walk(source_folder):
        progress.file_count = len(file_names)
        for file_index, file_name in enumerate(file_names, 1):
            source_path = join(root_folder, file_name)
            if not getsize(source_path):  # Skip empty files
                continue
            try:
                target_path = get_target_path(source_path)
            except DuplicateError as target_path:
                progress.show(file_index, 'skip', str(target_path))
                continue
            make_folder(dirname(target_path))
            progress.show(file_index, 'copy', target_path)
            copy2(source_path, target_path)  # Preserve file attributes
        if progress.file_count:
            print('')
    return dict(progress.count_by_message)


def get_target_path(source_path):
    timestamp = get_timestamp(source_path)
    timestamp_folder = timestamp.strftime('%Y/%m')
    target_name = BRACKET_PREFIX_PATTERN.sub('', basename(source_path)).strip()
    target_path = join(target_folder, timestamp_folder, target_name)
    if is_same(source_path, target_path):
        raise DuplicateError(target_path)
    target_path_generator = make_target_path_generator(target_path)
    while exists(target_path):
        if timestamp == get_timestamp(target_path):
            break
        target_path = next(target_path_generator)
    return target_path


def get_timestamp(path):
    epoch_time_in_seconds = getmtime(path)
    return datetime.fromtimestamp(epoch_time_in_seconds)


def is_same(source_path, target_path):
    if not exists(target_path):
        return False
    if getsize(source_path) != getsize(target_path):
        return False
    return True


def make_target_path_generator(target_path):
    target_base, target_extension = splitext(target_path)
    target_index = 0
    while True:
        yield '%s-%s%s' % (target_base, target_index, target_extension)
        target_index += 1


if __name__ == '__main__':
    source_folder, target_folder = sys.argv[1:]
    if realpath(source_folder) == realpath(target_folder):
        sys.exit('Source and target folders must be different')
    print(sort_music(source_folder, target_folder))

import datetime
import shutil
from argparse import ArgumentParser
from invisibleroads_macros.disk import make_folder
from os import walk
from os.path import expanduser, join
from random import sample


def run(target_folder, source_folder, sample_count):
    source_paths = []
    for root_folder, folder_names, file_names in walk(source_folder):
        for file_name in file_names:
            source_paths.append(join(root_folder, file_name))
    make_folder(target_folder)
    for source_path in sample(source_paths, sample_count):
        print(source_path)
        shutil.copy2(source_path, target_folder)


if __name__ == '__main__':
    timestamp = datetime.datetime.now().strftime('%Y%m%d-%H%M')
    argument_parser = ArgumentParser()
    argument_parser.add_argument('--target_folder', default=expanduser(
        '~/Downloads/music-playlists/') + timestamp)
    argument_parser.add_argument('--source_folder', default=expanduser(
        '~/Storage/music-archives'))
    argument_parser.add_argument('--sample_count', type=int, default=20)
    args = argument_parser.parse_args()
    run(args.target_folder, args.source_folder, args.sample_count)

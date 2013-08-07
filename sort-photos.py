#!/bin/env python
"Arrange photos in a YYYY/MM file structure."

# TODO: Keep folder names that have text
# TODO: Delete duplicates that are not in a folder
# TODO: Stay in containing folder if timestamp is very different

import datetime
import os
import shutil
import subprocess
import sys
from PIL import Image
from PIL.ExifTags import TAGS


def sort_photos(sourceFolder, targetFolder):
    template = '%s/%s\t%s\t%s'
    for rootFolder, subFolders, fileNames in os.walk(sourceFolder):
        fileCount = len(fileNames)
        for fileIndex, fileName in enumerate(fileNames, 1):
            if is_not_media(fileName):
                continue
            sourcePath = os.path.join(rootFolder, fileName)
            if not os.path.getsize(sourcePath):  # Skip empty files
                continue
            try:
                targetPath = get_targetPath(sourcePath)
            except DuplicateError as targetPath:
                print template % (fileIndex, fileCount, 'Skipping', targetPath)
                continue
            try:
                os.makedirs(os.path.dirname(targetPath))
            except OSError:
                pass
            print template % (fileIndex, fileCount, 'Writing', targetPath)
            shutil.copy2(sourcePath, targetPath)  # Preserve file attributes
        print


def is_not_media(fileName):
    fileName = fileName.lower()
    if fileName == 'thumbs.db':
        return True
    if fileName == 'desktop.ini':
        return True
    if fileName.endswith('.lnk'):
        return True
    if fileName.endswith('.thm'):
        return True
    return False


def get_targetPath(sourcePath):
    timestamp = get_timestamp(sourcePath)
    timestampFolder = timestamp.strftime('%Y/%m')
    sourceName = os.path.basename(sourcePath)
    targetPath = os.path.join(targetFolder, timestampFolder, sourceName)
    if is_same(sourcePath, targetPath):
        raise DuplicateError(targetPath)
    targetPathGenerator = make_targetPathGenerator(targetPath)
    while os.path.exists(targetPath):
        if timestamp == get_timestamp(targetPath):
            break
        targetPath = targetPathGenerator.next()
    return targetPath


def get_timestamp(path):
    try:
        image = Image.open(path)
    except IOError:
        pass
    else:
        exif = {TAGS[k]: v for k, v in image._getexif().items() if k in TAGS}
        return datetime.datetime.strptime(exif['DateTime'], '%Y:%m:%d %H:%M:%S')
    modificationTime = os.path.getmtime(path)
    return datetime.datetime.fromtimestamp(modificationTime)


def make_targetPathGenerator(targetPath):
    targetBase, targetExt = os.path.splitext(targetPath)
    targetIndex = 0
    while True:
        yield '%s-%s%s' % (targetBase, targetIndex, targetExt)
        targetIndex += 1


def is_same(sourcePath, targetPath):
    if not os.path.exists(targetPath):
        return False
    if os.path.getsize(sourcePath) == os.path.getsize(targetPath):
        commandArgs = ['cmp', '--silent', sourcePath, targetPath]
        return not subprocess.call(commandArgs)
    return False


class DuplicateError(Exception):
    pass


if __name__ == '__main__':
    sourceFolder, targetFolder = sys.argv[1:]
    if sourceFolder == targetFolder:
        print 'Source and target folders are the same!'
        sys.exit(1)
    sort_photos(sourceFolder, targetFolder)

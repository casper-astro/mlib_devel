#!/usr/bin/env python
"""
Get the git info for an fpg file and the library with which it was built.
"""
import subprocess
import os
import argparse
import sys
import time

parser = argparse.ArgumentParser(
    description='Get git info for a file/dir.',
    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument(dest='file_dir', type=str, action='store', default='',
                    help='file or dir to query')
parser.add_argument('--target', dest='target', type=str, action='store',
                    default='',
                    help='the file to which to append info')
parser.add_argument('--fpgstring', dest='fpgstring',
                    action='store_true', default=False,
                    help='return the result as lines of fpg meta')
parser.add_argument('--katversion', dest='katversion',
                    action='store_true', default=False,
                    help='use katversion to produce the meta info')
args = parser.parse_args()


class GitInfoError(RuntimeError):
    pass

if args.katversion:
    try:
        import katversion
    except ImportError:
        print('katversion does not seem to be available on this system.')
        sys.exit(-3)


def run_subproc(cmd):
    """

    :param cmd:
    :return:
    """
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                         shell=True)
    (output, err) = p.communicate()
    return output, err


def get_new_git_info(file_or_dir):
    """

    :param file_or_dir:
    :return:
    """
    try:
        file_or_dir = os.path.abspath(file_or_dir)
        if os.path.isdir(file_or_dir):
            dirname = file_or_dir
            filename = file_or_dir
        else:
            dirname = os.path.dirname(file_or_dir)
            filename = os.path.basename(file_or_dir)
        cmd1 = 'git -C {gitdir} log --max-count=1 --pretty=format:"%H - %ae' \
               ' - %aD" {fpath}'.format(gitdir=dirname, fpath=filename)
        cmd2 = 'git -C {gitdir} --no-pager status --porcelain -uno -- ' \
               '{fpath}'.format(gitdir=dirname, fpath=filename)
        cmd3 = 'git -C {gitdir} --no-pager status -uno -- {fpath}'.format(
            gitdir=dirname, fpath=filename)
        cmd4 = 'git -C {gitdir} --no-pager config --get remote.origin.url' \
               ''.format(gitdir=dirname, fpath=filename)
        (hostname, err) = run_subproc('hostname')
        if err != '':
            raise GitInfoError('Could not determine hostname')
        (username, err) = run_subproc('id -un')
        if err != '':
            raise GitInfoError('Could not determine username')
        (output1, err) = run_subproc(cmd1)
        if err != '':
            raise GitInfoError('Error getting git log')
        (output2, err) = run_subproc(cmd2)
        if err != '':
            raise GitInfoError('Error getting modified files from git')
        output2 = output2.split('\n')
        modified_files = []
        for val in output2:
            if val != '':
                modified_files.append(val)
        (output3, err) = run_subproc(cmd3)
        if err != '':
            raise GitInfoError('Error getting branch info from git')
        output3 = output3.split('\n')
        (output4, err) = run_subproc(cmd4)
        output4 = output4.replace('\n', '')
        if err != '':
            raise GitInfoError('Error getting remote origin from git')
        gitstring = '{filename}\t[{username}@{hostname}]\t[{origin}]\t' \
                    '[{hashstring}]\t' \
                    '[{branch}]\t{modified_files}'.format(
                        username=username.replace('\n', ''),
                        hostname=hostname.replace('\n', ''),
                        hashstring=output1 or
                        'File not in Git. Compiled: {}'.format(
                            time.strftime("%a, %d %b %Y %H:%M:%S %z")),
                        branch=output3[0] + ' - ' + output3[1],
                        modified_files=modified_files,
                        filename=file_or_dir,
                        origin=output4)
    except GitInfoError as e:
        gitstring = '{filename}\tCompiled: {compile_time}\t{err}'.format(
            filename=file_or_dir,
            compile_time=time.strftime("%a, %d %b %Y %H:%M:%S %z"),
            err=str(e)
        )
    return gitstring

if args.katversion:
    new_info = args.file_dir + '\t' + katversion.get_version(args.file_dir)
else:
    new_info = get_new_git_info(args.file_dir)
if args.target:
    try:
        fptr = open(args.target, 'a')
    except IOError:
        sys.exit(-2)
    fptr.write(new_info)
    fptr.close()
elif args.fpgstring:
    print('?meta\t77777_git\trcs\t{}'.format(new_info)),
else:
    if not os.path.exists(args.file_dir):
        print ('ERROR no_such_file: ' + args.file_dir)
        sys.exit(-1)
    print(new_info)

# end

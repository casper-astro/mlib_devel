#!/usr/bin/env python
"""
Get the git info for an fpg file and the library with which it was built.
"""
import subprocess
import os
import argparse

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
                    help='return the result as linesof fpg meta')
args = parser.parse_args()


class GitInfoError(RuntimeError):
    pass


def get_commit_hash(file_or_dir):
    """
    Get the latest git commit hash for a file or dir
    :param file_or_dir:
    :return:
    """
    if os.path.isdir(file_or_dir):
        dirname = file_or_dir
    else:
        dirname = os.path.dirname(file_or_dir)
    p = subprocess.Popen('git -C %s log -n 1 -- %s' % (dirname, file_or_dir),
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE,
                         shell=True)
    (output, err) = p.communicate()
    if err != '':
        raise GitInfoError('%s: error running git log:\n\t%s' %
                           (file_or_dir, err))
    commit_hash = output.replace('commit ', '')
    if commit_hash.find('\n') != 40:
        raise GitInfoError('%s: hash length incorrect' % file_or_dir)
    commit_hash = commit_hash[0:40]
    return commit_hash


def get_status(file_or_dir):
    """
    Get the git status for a file or dir
    :param file_or_dir:
    :return: str: modified or unmodified
    """
    if os.path.isdir(file_or_dir):
        dirname = file_or_dir
    else:
        dirname = os.path.dirname(file_or_dir)
    p = subprocess.Popen('git -C %s status --porcelain -- %s' %
                         (dirname, file_or_dir),
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE,
                         shell=True)
    (output, err) = p.communicate()
    if err != '':
        raise GitInfoError('%s: error running git status:\n\t%s' %
                           (file_or_dir, err))
    if output.strip() == '':
        return 'unmodified'
    outlist = output.split('\n')
    modifications = []
    for line in outlist:
        if line[0:2] == ' M':
            modifications.append(line.strip())
    if modifications:
        return 'modified-' + str(modifications).replace(' ', '\\_')
    else:
        return 'unmodified'


def get_config(file_or_dir):
    """
    Get the git config for a file or dir
    :param file_or_dir:
    :return: str: modified or unmodified
    """
    if os.path.isdir(file_or_dir):
        dirname = file_or_dir
    else:
        dirname = os.path.dirname(file_or_dir)
    p = subprocess.Popen('git -C %s config -l' % dirname,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE,
                         shell=True)
    (output, err) = p.communicate()
    if err != '':
        raise GitInfoError('%s: error running git config:\n\t%s' %
                           (file_or_dir, err))
    outlist = output.split('\n')
    output = {}
    for line in outlist:
        if line.strip(''):
            _line = line.split('=')
            output[_line[0]] = _line[1]
    return output

if args.target:
    try:
        fptr = open(args.target, 'a')
    except IOError:
        import sys
        sys.exit(-2)
    _fname = args.file_dir.replace(' ', '\\_')
    _prefix = '?meta 77777_git rcs %s' % _fname
    try:
        githash = get_commit_hash(args.file_dir)
        gitstat = get_status(args.file_dir)
        gitconfig = get_config(args.file_dir)
        fptr.write('%s git_info_found 1\n' % _prefix)
        fptr.write('%s commit_hash %s\n' % (_prefix, githash))
        fptr.write('%s status %s\n' % (_prefix, gitstat))
        for k in gitconfig:
            param_str = k.replace(' ', '\\_')
            value_str = gitconfig[k].replace(' ', '\\_')
            fptr.write('%s %s %s\n' % (_prefix, param_str, value_str))
    except:
        fptr.write('%s git_info_found 0\n' % _prefix)
    fptr.close()
elif args.fpgstring:
    _fname = args.file_dir.replace(' ', '\\_')
    _prefix = '?meta 77777_git rcs %s' % _fname
    fpgstring = ''
    try:
        githash = get_commit_hash(args.file_dir)
        gitstat = get_status(args.file_dir)
        gitconfig = get_config(args.file_dir)
        fpgstring += '%s git_info_found 1\n' % _prefix
        fpgstring += '%s commit_hash %s\n' % (_prefix, githash)
        fpgstring += '%s status %s\n' % (_prefix, gitstat)
        for k in gitconfig:
            param_str = k.replace(' ', '\\_')
            value_str = gitconfig[k].replace(' ', '\\_')
            fpgstring += '%s %s %s\n' % (_prefix, param_str, value_str)
    except:
        fpgstring += '%s git_info_found 0\n' % _prefix
    print fpgstring,
else:
    if not os.path.exists(args.file_dir):
        print 'ERROR-no_such_file'
        import sys
        sys.exit(-1)
    githash = get_commit_hash(args.file_dir)
    gitstat = get_status(args.file_dir)
    print githash, gitstat

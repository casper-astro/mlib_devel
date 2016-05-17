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
                    help='return the result as lines of fpg meta')
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
    hashlen = commit_hash.find('\n')
    if hashlen != 40:
        raise GitInfoError('%s: hash length incorrect, wanted 40, got %i' % (file_or_dir, hashlen))
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

if args.target or args.fpgstring:

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

    def _info_to_lines(file_or_dir):
        gitlines = []
        try:
            ghash = get_commit_hash(file_or_dir)
            gstat = get_status(file_or_dir)
            gconfig = get_config(file_or_dir)
            gitlines.append('git_info_found\t1\n')
            gitlines.append('commit_hash\t%s\n' % ghash)
            gitlines.append('status\t%s\n' % gstat)
            for key in gconfig:
                param_str = key.replace(' ', '\\_')
                value_str = gconfig[key].replace(' ', '\\_')
                gitlines.append('%s\t%s\n' % (param_str, value_str))
        except Exception as e:
            gitlines.append('git_info_found\t0\n')
            raise e
        _fname = file_or_dir.replace(' ', '\\_')
        prefix = '?meta 77777_git\trcs\t%s' % _fname
        for ctr in range(len(gitlines)):
            gitlines[ctr] = '%s\t%s' % (prefix, gitlines[ctr])
        return gitlines

    # get the info in a list
    lines = _info_to_lines(args.file_dir)

    if args.target:
        try:
            fptr = open(args.target, 'a')
        except IOError:
            import sys
            sys.exit(-2)
        for line in lines:
            fptr.write(line)
        fptr.close()
    elif args.fpgstring:
        fpgstring = ''
        for line in lines:
            fpgstring += line
        print fpgstring,
else:
    if not os.path.exists(args.file_dir):
        print 'ERROR-no_such_file'
        import sys
        sys.exit(-1)
    githash = get_commit_hash(args.file_dir)
    gitstat = get_status(args.file_dir)
    print githash, gitstat

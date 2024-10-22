#!/bin/python3

import os
import toml

HOME = os.getenv('HOME')

CONFIG_NAME = 'config.toml'
DOTFILES_PATH = f'{HOME}/.dotfiles'
IGNORED_ENTRIES = ['.git', 'scripts']

GREEN = '\033[92m'
BLUE = '\033[94m'
RESET = '\033[0m'

def read_entris(path: str) -> list:
    return [entry for entry in os.listdir(path)]
def read_folders(path: str) -> list:
    return [entry for entry in read_entris(path) if os.path.isdir(os.path.join(path, entry))]
def create_link(src_path: str, dst_path: str):
    os.system(f'ln -s {src_path} {dst_path}')
def create_copy(src_path: str, dst_path: str):
    os.system(f'cp -r {src_path} {dst_path}')

def get_all_srcs() -> list:
    return [os.path.join(DOTFILES_PATH, entry) for entry in read_folders(DOTFILES_PATH) if entry not in IGNORED_ENTRIES]

def get_dst_by(src_path: str) -> tuple[str, str]:
    with open(os.path.join(src_path, CONFIG_NAME), 'r') as config:
        config = toml.load(config)
        dst: str = config['destination']['dir'].replace('~', HOME)
        deploy: str = config['destination']['deploy']
    return dst, deploy

def deploy_sub_enties(src_parent_path: str, dst_parent_path: str, deploy_ops: str) -> None:
    sub_srcs = [os.path.join(src_parent_path, entry) for entry in read_entris(src_parent_path)]
    sub_srcs.remove(os.path.join(src_parent_path, CONFIG_NAME))
    sub_dsts = [os.path.join(dst_parent_path, entry) for entry in read_entris(src_parent_path)]
    sub_dsts.remove(os.path.join(dst_parent_path, CONFIG_NAME))
    for src, dst in zip(sub_srcs, sub_dsts):
        if os.path.islink(dst):
            os.system(f'rm {dst}')
        if os.path.exists(dst):
            print(f'{BLUE}Backup {dst}{RESET}')
            os.system(f'mv {dst} {dst}.bak')
        if deploy_ops == 'copy':
            print(f'{BLUE}Copy {src} -> {dst}{RESET}')
            create_copy(src, dst)
        elif deploy_ops == 'link':
            print(f'{BLUE}link {src} -> {dst}{RESET}')
            create_link(src, dst)

def main():
    srcs = get_all_srcs()
    for src in srcs:
        dst, deploy_ops = get_dst_by(src)
        print(f"{GREEN}Deploying {src}{RESET}")
        deploy_sub_enties(src, dst, deploy_ops)

if __name__ == '__main__':
    main()

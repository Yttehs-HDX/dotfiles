#!/bin/python3

import os

HOME = os.environ['HOME']
AUR = 'yay'

PACMAN_LIST_PATH = f'{HOME}/.dotfiles/.scripts/pacman.txt'
AUR_LIST_PATH = f'{HOME}/.dotfiles/.scripts/aur.txt'

BLUE = '\033[94m'
GREEN = '\033[92m'
RESET = '\033[0m'

def read_file(path: str) -> list:
    with open(path, 'r') as f:
        return f.read().splitlines()
def pacman_install(pkgs: list) -> None:
    os.system(f'sudo pacman -S {' '.join(pkgs)}')
def aur_install(pkgs: list) -> None:
    os.system(f'yay -S {' '.join(pkgs)}')

def main():
    print(f'{GREEN}Updating system{RESET}')
    os.system('sudo pacman -Syu')
    pacman_list = read_file(PACMAN_LIST_PATH)
    aur_list = read_file(AUR_LIST_PATH)
    print(f'{GREEN}Installing pacman pkgs{RESET}')
    pacman_install(pacman_list)
    print(f'{GREEN}Installing aur pkgs')
    aur_install(aur_list)

if __name__ == '__main__':
    main()

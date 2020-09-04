#!/bin/bash

set -e

test::check_syntax() {
  ansible-playbook playbook.yml -i 'localhost' -e '{"packages_to_install": ["i3"], "packages_to_uninstall": ["git"]}' --syntax-check
}

test::run_ansible() {
  ansible-playbook playbook.yml -i 'localhost' -e '{"packages_to_install": ["i3"], "packages_to_uninstall": ["git"]}'
}

test::assert_output() {
  for package in i3; do
    if ! pacman -Qe | grep -q $package; then
      echo "$package is not installed"
      exit 1
    fi
  done

  for package in git; do
    if which "$package"; then
      echo "$package is installed, and should not be"
      exit 1
    fi
  done
}

test::check_syntax
test::run_ansible
test::assert_output

#!/usr/bin/env bash
#
#
# This script will install certain packages that I want
#

indent()
{
	sed 's/^/   /'
}

install_packages_i_like()
{
    sudo apt install redis-server pipenv python3-pip postgresql-12

}

main()
{
	echo "Installing packages I like"
	install_packages_i_like | indent
}

main
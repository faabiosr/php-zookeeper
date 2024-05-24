#!/bin/sh -e
__CURRENT__=$(cd "$(dirname "$0")";pwd)
__DIR__=$(cd "$(dirname "${__CURRENT__}")";pwd)

cd "${__DIR__}"
rm -fr ${__DIR__}/tmp

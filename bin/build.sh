#!/bin/bash
# выхожу, если одна из команд завершилась неудачно
set -e

# удаляю билды
yarn clean

# устанавливаем ограничение на количество параллельных процессов при сборке (default - 10)
CONCURRENCY=${BUILD_CONCURRENCY:=10}

echo "start build on $CONCURRENCY parallel process"

# собираю все подпакеты, за исключением css-пакетов (vars, themes)
lerna exec --concurrency $CONCURRENCY \
    --ignore @alfalab/core-components-vars-test \
    --ignore @alfalab/core-components-themes-test \
    -- $(pwd)/bin/rollup.sh

# собираю css пакеты
copy_css="yarn copyfiles -u 1 \"src/**/*.css\" dist"
copy_package="yarn copyfiles package.json dist"
lerna exec \
    --scope @alfalab/core-components-vars-test \
    --scope @alfalab/core-components-themes-test \
    -- "$copy_css && $copy_package"

# собираю пакет themes
lerna exec --scope @alfalab/core-components-themes-test -- node $(pwd)/bin/build-themes.js

# копирую собранные css пакеты в корневой пакет
copy_to_root="mkdir -p ../../dist/\${PWD##*/} && cp -r dist/ ../../dist/\${PWD##*/}"
lerna exec \
    --scope @alfalab/core-components-vars-test \
    --scope @alfalab/core-components-themes-test \
    -- $copy_to_root

# копирую package.json в сборку корневого пакета
cp package.json dist/package.json

# делаю корневой пакет публичным
yarn json -f dist/package.json -I -e "delete this.private" -e "delete this.workspaces"

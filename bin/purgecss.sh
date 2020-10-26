#!/bin/bash

# удаляем неиспользуемые css-переменные из сборки в root-пакете
node bin/purgecss.js

# удаляем неиспользуемые css-переменные из сборки во всех подпакетах
lerna exec --parallel \
    --ignore @alfalab/core-components-vars \
    --ignore @alfalab/core-components-themes-test \
    -- node ../../bin/purgecss.js

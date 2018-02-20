#!/bin/bash

cleancss static/css/style.css | gsed 's/\/\*!/\n&/g' | gsed 1d > static/css/style.min.css
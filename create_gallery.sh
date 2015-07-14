#!/bin/bash

# Copyright (c) 2015, socapex
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies,
# either expressed or implied, of the FreeBSD Project.

shopt -s nullglob

usage="$(basename "$0") [web address] [png directory] -- program to generate a big html gallery"

echo "<table style='width: 100%;'>
<tbody>" > gallery.html;

i=0;
for f in "$2"/*.png; do
    ((++i))

    f="${f##*/}"

    name=$f
    name="${name%.*}"
    name="${name//-/ }"
    name="${name//[0-9]}"

    if (($i==1)); then
        echo "<tr>" >> gallery.html;
    fi

    echo "<td style='height: 200px; text-align: center; font-size: 11px;' align='center'>
            <a href='$1/$f' target='_blank'><img style='margin-top: 12px;' src='$1/Thumbnails/${f%.*}.jpg' alt='$name thumbnail' width='200' height='200' /></a>
            <br />
            <a style='color: #4d4d4d; font-weight: bold; text-decoration: none;' href='$1/$f' target='_blank'>$name</a>
        </td>" >> gallery.html;

    if (($i==3)); then
        echo "</tr>" >> gallery.html;
        i=0;
    fi

done;

if (($i!=3)); then
    echo "</tr>" >> gallery.html;
fi

echo "</tbody>
</table>" >> gallery.html;

#/bin/bash

echo $DIR_PDF/$DIR_THEME
echo $DIR_PDF/$DIR_FONTS
echo $DEFAULT_STYLE
echo $DEFAULT_FILE

asciidoctor-pdf -a pdf-stylesdir=$DIR_PDF/$DIR_THEME -a pdf-fontsdir=$DIR_PDF/$DIR_FONTS -a  pdf-style=$DEFAULT_STYLE $DEFAULT_FILE

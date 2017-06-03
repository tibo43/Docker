#/bin/bash

check() {
  if [ $? = 0 ] ; then
    printf "\nGeneration OK."
  else
    printf "\nProblem while generation."
  fi
}

printf "\nGit clone AsciiDoctor Theme repository"
git clone https://github.com/tibo43/asciidoctor_theme.git /theme

printf "\nExecute asciidoctor-pdf command\n"
asciidoctor-pdf -a pdf-stylesdir=$DIR_PDF/$DIR_THEME -a pdf-fontsdir=$DIR_PDF/$DIR_FONTS -a  pdf-style=$DEFAULT_STYLE $DEFAULT_FILE

check

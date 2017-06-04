#/bin/bash

default() {
  if [ $DEFAULT_GEN = "default" ] ; then
    echo "\nYou need to set the type of generation : pdf or reveal-js"
    exit 1
  else
    printf "\nGit clone AsciiDoctor Theme repository\n"
    git clone https://github.com/tibo43/asciidoctor_theme.git /theme
  fi
}

check() {
  if [ $? = 0 ] ; then
    printf "\nGeneration OK."
  else
    printf "\nProblem while generation."
  fi
}

default
if [ $DEFAULT_GEN = "pdf" ] ; then
  printf "\nExecute asciidoctor-pdf command to generate the pdf\n"
  asciidoctor-pdf -a pdf-stylesdir=$DIR_PDF/$DIR_PDF_THEME -a pdf-fontsdir=$DIR_PDF/$DIR_PDF_FONTS -a  pdf-style=$DEFAULT_STYLE $DEFAULT_FILE
elif [ $DEFAULT_GEN = "reveal-js" ] ; then
  cp -R $DIR_REVEALJS/reveal.js html
  printf "\nExecute asciidoctor command to generate the reveal-js\n"
  asciidoctor -T $DIR_REVEALJS/$DIR_REVEALJS_SLIM -o html/$DEFAULT_FILE.html -a backend=revealjs $DEFAULT_FILE
else
  printf "\n$DEFAULT_GEN is not a right choice. only pdf or reveal-js are possible"
  exit 2
fi
check

exit 0

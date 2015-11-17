# Random Word Generator
This is a simple application written in AutoHotkey designed to generate random words (or strings) based on simple rules.
## Overview
The rules according to which words are generated are called *templates*. Each template is a sequence of *symbols*. 
Each *symbol* will be replaced with one from a number of letters (or characters, symbols, dyphtongs, etc) with a certain probability, according to whether the letter appears at the beginning, in the middle, or at the end of the word.
<br><br>
For instance, one may create symbols `v` and `c` and assign to each of them some vowels, and some consonants, respectively, with some frequencies of appearance. Then he may create templates such as `vvc`, which will render words with two vowels followed by a consonant, etc

## Running and compiling
You may run the app by running the `main.ahk` script, provided that you have the latest version of AutoHotkey, but it should also run on older versions.

The script can be turned into an exe capable of running with no prerequisites using AHK's converter.

## Screenshots
(https://raw.githubusercontent.com/petru-dimitriu/gac/master/generator.png)
(https://raw.githubusercontent.com/petru-dimitriu/gac/master/symbols.png)
(https://raw.githubusercontent.com/petru-dimitriu/gac/master/templates.png)

## Limitations
* Somewhat slow & silly.
* Currently lacks some error checking.
* Some import/export features not implemeneted.

## License
I hereby release this to the public domain. I don't mind if you credit me, though.
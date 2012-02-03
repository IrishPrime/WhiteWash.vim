A Vim plugin to remove excessive white space and annoyances from files.
Strips visible ^M's from the end of lines.
Removes white space at the end of lines.
Removes sequential white space between words.
Ignores white space at the beginning of a line (to preserve indents).

Has one option:
* WhiteWash\_Aggressive - Causes aggressive behavior by default.

rovides three functions:
* WhiteWash() - Strips trailing ^M's, trailing white space, and Calls WhiteWashLazy or WhiteWashAggressive based on user preferences.
* WhiteWashLazy() - Removes sequential white space between word characters, but not between punctuation.
* WhiteWashAggressive - Removes sequential white space anywhere but the beginning of a line.

# regexp examples 
# http://www.youtube.com/watch?v=q8SzNKib5-4&list=PLjTlxb-wKvXOdzysAE6qrEBN_aSBC0LZS

#    ^word this searches the beginning of the line
#    word$   will look for the word at end of the line
#    [Bb][Uu][Ss][Hh]  will look for bush with capital and small letters 
#    [^.?]$   This ^ when inside bracket means search end of line without . or ? (different to ^
          # outside the square bracket)
#   . refers to any character
#    [Gg]eorge ([wW]\.)? Bush   the ? means the [wW] is optional, the \ is escape the ., which
          # would normally indicate any letter, is now searching specifically for .
#   * and + indicates repetition of the previous literal or meta character, with + meaning 
          # repeated at least once


#  Bush( +[^ ] +){1,5} debate      : This searches for Bush (1 to 5 words) debate
      #space repeat, no space, space repeated : this is a word after bush
#  " +([a-zA-Z]+) +\1 + "  searches for any word repeated twice, +\1 means repeat the expression
                  # in the previous parenthesis
#   s(.*)s  : the . is greedy - it will accept long sentences beginning and ending with s, with
        # many s's in between
    #s(.?)s   : this will find the shortest string from s to s



# grep, grepl
# regexpr, gregexpr
# sub, gsub
# regexec

regIndex <- regexpr("GOOG/[A-Z]*_LULU", searchResult)
# substr(searchResult[1], 56, 56+16-1)
regmatches(searchResult, regIndex)
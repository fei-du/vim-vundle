#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

# [find]
    # find location comparison-criteria search-term
    find
    find examples/
    find configs/
    find configs/ -name "*6ul*"
    find configs/ -iname "*6ul*"
    find drivers -name "*.c"
    # limit depth of directory traversal
    find -maxdepth 1 -name "*.h*"
    find -maxdepth 2 -name "*.h"
    find -maxdepth 3 -name "*.h"
    find configs/ -not -name "*mx6*"
    # invert match
    find configs/ -not -name "*mx6*"
    # combine multipe search criterias
    find -maxdepth 3 -name '*common*'  -name "*.h"
    find -maxdepth 3 -name '*common*'  -name "*mx6*"
    find -maxdepth 3 -name '*common*' ! -name "*.h"
    # or operator
    find -maxdepth 3 -name '*common*' -o  -name "*.h"
    search only files or only directories
    find -type d -name cmd
    # search multiple directories together
    find cmd/ common/ -type f -name  "*file*"
    # find hidden files
    find -type f -name ".*"
    # find files modified accessed in a period
    find  -atime 50
    find -mtime 50
    find -mtime +50 -mtime -100
    find / -mtime +50 -mtime -100
    find / -mtime 50
    find / -atime 50
    find -cmin -60
    find -mmin -60
    find -amin -60
    # find empty files and directories
    find /tmp -type f -empty
    find /tmp -type d -empty
    # find largest and smallest files
    find cmd/ -name "*mm*" -exec ls -s {} \;
    find cmd/ -name "*mm*" -exec ls -s {} \; | sort
    find cmd/ -name "*mm*" -exec ls -s {} \; | sort -n
    find cmd/ -name "*mm*" -exec ls -s {} \; | sort -n -r
    # list out the found files
    find cmd/ -name "*mm*" -exec ls -ld {} \; | sort -n -r
    find /tmp -type f -name "*.txt" -exec rm -f {} \;
    find ~ -type f -name *.log -size +10M -exec rm -f {} \;
    # grouping expressions together: Makefile or any directory
    find \( -name Makefile -type f \) -or -type d
    # actions
    -print # default
    -delete
    -exec

# [grep]
    # grep "string" file_pattern
    grep this demo_file*
    grep -i line demo_file
    # regular expression
    grep "line.*emp" demo_file
    grep line.*emp demo_file
    grep -i is demo_file
    # check for full words
    grep -iw is demo_file
    grep -i -w is demo_file
    # context line control
    grep -A 3 -i sit random_file
    grep -B 2 -A 3 -i sit random_file
    grep -C 2 -i sit random_file
    grep -r "ramesh" *
    # invert match
    grep -v "go" demo_file
    # display lines not matching all given pattern
    grep -v -e "pattern" -e "pattern"
    # display only the file name
    grep -l this demo*
    # show only matched string
    grep -o is.*line demo_file
    grep IFS * -n -C 3

# [tar]
    # tar function [options] object1 object2
    tar -cvf a.tar gitconfig setup.sh
    tar -tf a.tar
    tar -xvf a.tar

# [option]
    getopt ab:cd -a -b test1 -cd test2 test4
    getopt ab:cd -a -b test1 -cde test2 test4
    getopt -q ab:cd -a -b test1 -cde test2 test4

# [xargs]
    # read data from stdin and executes command(supplied) one or more times based on the input read
    find ./music -name "*.mp3" -print0 | xargs -0 ls
    # find all file in work folder, pass to grep and search for profit
    find ./work -print | xargs grep "profit"
    # find and delete files which have been modified in the last 30 mins:
    find ./work -mmin -30 | xargs -0 rm
    find ./work -print0 | xargs -0 rm
    # run diff on file pairs, should be invoked as a shell script
    echo $* | xargs -n2 diff
    # read a list of filename from filelist.txt and copy them to new_folder
    xargs -a filelist.txt cp -t new_folder
    xargs -L 1 find -name
    {} as the argument list marker for commands taking more than two arguments
    # dealing file name with blank spaces and newline
    find . -name "*.sh" -print0 | xargs -0 -I {} mv {} ~/back.scripts
    find . -name "*.sh" -print0 | xargs -0 -I file mv file ~/back.scripts
    # convert multiline output to single line
    find . -name "*sh" | xargs
    find . -name "*sh" | xargs grep "ksh"
    ls -l *sh | xargs
    ls -l *.sh | xargs wc -l
    cut -d, -f1 smartphone.csv | sort | xargs
    ls | xargs -t -I {} mv {} {}.old
    # run a command on files that you select individually
    # select files to add to the lib.a library, -p flag to confirm
    ls | xargs -p -n 1 ar r lib.a
    # construct a command containing a specific number of arguments and to insert those into the middle of a command line
    ls | xargs -n 6 | xargs -I {} echo {} - some files in the directory

# [misc]
    # without the dollar sign, the shell interprest the variable name as a normal text string
    # the ESC character is entered in vi by typing CTRL-V followd by pressing ESC key.
    # math equation $[1+ 5] supports only integer arithmetic
    # exit status codes can only go up to 255
    # double parentheses allows to incorporate advanced mathematical formulas, and assigning values
    # subshell $()
    # double brackets for string comparisons: pattern matching
    # bash shell automatically gives error messages a higher priority than the standard output.
    # use subshell to capture the output of a function to a shell variable
    # variable defined in function is global, unless use local keyword.
    # ctrl+x ctrl+e to edit current command line in vim EDITOR
    testfile=$(ls *.sh)
    echo $testfile
    # using echo to output an unquoted variable set with command subsitution removes trailing new lines characters from the output of the reassigned command. this can cause unpleasant surprises
    echo "$testfile"
    # arithmetic expansion
    z=$(($z+3))
    z=$((z+3)) # also correct. within double parentheses, parameter dereferencing is optional
    # $((expression)) # not to be confused with command subsitution
    # list OS and kernel version
    uname -a | cut -d" " -f1,3,11,12
    # redirect both stdout and stdin to file "filename"
    &>filename
    # redirect stderr to stdout
    2>&1
    # redirect i to j
    i>&j
    # redirect, by default, stdout to j
    >&j
    # Closing File Descriptors
	# Close input file descriptor n.
	n<&-
	# Close stdin.
	0<&-, <&-
	# Close output file descriptor n.
	n>&-
	# Close stdout.
	1>&-, >&-
    # here documents are a special case of redirected code blocks. that being the case, it should be possible to feed the output of a here document into the stdin for a while loop
    # in general, an exteranl command in a script forks off a subprocess, whereas bash builtin does not. For this reason, builtins execute more quickly and use fewer system resources than their exteranl command equivalents
    # variables in a subshell are not visiable outside the block of code in subshell. These are, in effect, variables local to the child process
    # Directory changes made in a subshell do not carry to the parent shell.
    # a subshell may be used to set up a "dedicated environment"for a command group
	    (
	    IFS=:
	    PATH=/bin
	    unset TERMINFO
	    set -C
	    shift 5
	    COMMAND4
	    COMMAND5
	    exit 3 # Only exits the subshell!
	    )
	# one application of such a "dedicated environment" is testing whether a variable is defined.
	    if (set -u; : $variable) 2> /dev/null
	    then
		echo "variable is set."
	    fi
	# another application is checking for a lock file:
	    if (set -C; : > lock_file) 2> /dev/null ; then
		: # lock_file didn't exist: no user running the script
	    else
		echo "another user is already running that script."
		exit 65
	    fi
	# process Substitution
	    # piping the stdout of a command into the stdin of another is a powerful technique. but, what if you need to pipe the stdout of multiple commands? this is where process subsitution comes in.
	    # process subsitution use /dev/df/<n> files to send the results of the process(es) within parentheses to another process
		wc cheatsheet.sh
		grep command cheatsheet.sh | wc
		wc <(grep command cheatsheet.sh)
	    # process subsitution can compare the output of two different commands, or even the output of different options to the same command
		comm <(ls -l) <(ls -al)
	    # process subsitution can compare the contents of two directories -- to see which filenames are in one, but not the other.
		diff <(ls $first_directory) <(ls $second_directory)
		cat <(ls -l) # same as ls -l | cat
		sort -k 9 <(ls -l /bin) <(ls -l /usr/bin)
		diff <(command1) <(command2) #gives differences in command output
    # [function]
	# a function may be "compacted"into a single line. In this case, a semicolon must follow the final command in the function
	    fun () { echo "this is a function"; }
	    fun
	# in contrast to C, a bash variable declared inside a function is local only if declared as such.
	# before a function is called, all variables declared within the function are invisible outside the body of the function, not just those explicitly declared as local.
    # [list constructs]
	# the and list and or list constructs provide a means of processing a number of commands consecutively. These can effectively replace complex nested if/then or even case statements.
	    # command-1 && command-2 && command-3
	    # command-1 || command-2 || command-3
    # [options]
	# options are settings that change shell and/or script behavior.
	set -o option-name
	set -option-abbrev # these two forms are equivalent.
	# echoes all commans before executing
	set -o verbose
	set -v
	# to disable an option within a script, use
	set +o option-name
	set +option-abbrev
	# an alternate method of enabling options in a script is to specify them immediately following the #! script header
	#!/bin/bash -x
    # [gotchas]
	# not terminating with a semicolon the final command in a code block within curly brackets
	{ls -l; df; echo "doen";}
	# mixing up = and -eq in a test. Remember, = is for comparing literal variables and -eq for integers.
	# misusing string comparison operators
	while [ "$number" < 5 ] #wrong! try to use a string comparison on integers
	while [ "$number" -lt 5 ] # should be.
	# attempting to use let to set string variables
	# sometimes variables within "test" bracket ([]) need to be quoted (double quotes)
	# quoting a variable containing whitespace prevents splitting. sometime this produces unintended consequences.
	# a script with DOS-type newlines (\r\n) will fail to execute, since #!/bin/bash\r\n is not recognized, not the same as the expected #!/bin/bash\n. the fix it to convert the script to unix-style newlines.
	# insert a literal tab in bash shell command line: control + v, then tab. if you see the cursor over to the right, it worked.

# [git]
    # check whether remote has changed
    git ls-remote origin -h refs/heads/master
    # Generate diffs with <n> lines of context instead of the usual three
    git diff  -U10 clock_config.c

# [sed]
    # sed is implicitly global.
    # a sed command can specify zero, one, or two addresses. an address can be a regular expression describing a pattern, a line number, or a line addressing symbol.
    # the line numbers refers to an internal line counter maintained by sed. This counter is not reset for multiple input files. There is only one line 1 in the input stream.
    # the first address as enabling the action and the second address as disabling it. Sed has no way of looking ahead to determine if the second match will be made.
    # an exclamation mark (!) following an address reverses the sense of match.
    # the default action is to print each line that matches the pattern.
    # in the replacement section, only the following characters have special meaning:
	# & replaced by the string matched by the regular expression
	# \n  Matches the nth substring previously specified in the pattern using "\(" and "\)". we can use a similar technique to match parts of a line and swap them.
	# \ used to escape
	# if a script contains multiple substitue commands that match the same line, multiple copies of that line will be printed or written to file.
    # sed conforms only to a subset of the BRE for the speed
    # the change, insert, append commands must be specified over multiple lines and can not be specified on the same line.
    # Remember \b is a word boundary. \w is a single 'word' character. sed by default requires + to be escaped. the regex to match a word is \b\w\+\b, we repeat the matched word, use backreferences and we need to capture first. Capturing parenthesis need to be escaped. \1 is backreference to whatever was matched by the regex within the parenthesis: \(\b\w\+\b\) \1
    cat text_repeat.txt | sed 's/\(\b\w\+\b\) \1/\1/g'
    # or all lines except the second line
    cat text.txt | sed '2!s/\(\b\w\+\b\) \1/\1/g'
    # remove empty lines
    cat comfile.txt | sed -e '/^\( \|\t\)*$/d'
    cat comfile.txt | sed -e '/^[ \t]*$/d'
    sed '2{s/ab/xx/g; s/ac/yy/g}'
     # search
	s/pattern/replacement/flags
	    a number: indicating pattern occurence for which new text shold be subsituted
	    g, indicating for all occurences
	    p, indicating original line should be printed
	    w file, writing subsituted line to a file, together with -n option
	sed 's!/bin/bash!/bin/csh!' /etc/passwd

	address {
	    command1
	    command2
	    command3
	}
	sed '2,3s/dog/cat/' data1.txt
	/pattern/command
	sed '/dufei/s/bash/csh/' /etc/passwd
    # deleting lines
	# the delete command is also a command that can change the flow of contorl in a script. Once it is executed, it causes a new line to be read and a new pass on the editing script to begin from the top. In this befavior, it it the same as the next command.
	# to delete a portion a line, use the substitue command and specify an empty replacement.
	sed '2,3d' data1.txt
	sed '/number 1/d' data1.txt
    # inserting and appending text
	# the supplied text must start on a line by itself and cannot be on the same line as the append command.
	echo "test line 2" | sed 'i\test line 1'
	echo "test line 2" | sed 'a\test line 1'
	# the insert command can be used to put a blank line before current line, or the append command to put one after, by leaving the line following it blank.
	sed '1a\
		' data1.txt
	sed '1i\
	so maroc\
	ds chfist' data1.txt
	sed '$a\
	    This is a new line of test' data1.txt
	sed '1i\
	    this is one line of text.\
	    this is another line of new text.' data1.txt
    # changing lines
	# the change command, however, can address a range of lines. it replaces all addressed lines with a single copy of the text. Note that you will see the opposite behavior when the change command is one of a group of commands enclosed in braces, that act on a range of lines. it will output 10 times if there are 10 lines in the range.
	# the change command clears the pattern space, having the same effect on the pattern space as the delete command. The insert and append do not affect the contents of the pattern space. the supplied text will not match any address in subsequent commands in the script, nor can those commands affect the text. this is also true when the default output is suppressed - the supplied text will be output even if the pattern space is not. also the supplied text does not affect sed's internal line counter.
	sed '3c\
	    this is a changed line of text'  data1.txt
	sed '/number 3/c\
	    this is a changed line of text'  data1.txt
    # transforming characters: performing a one to one mapping of the inchars and outchars
	sed 'y/1234/6789/' data1.txt
    # printing lines
	# the print command might be used for debugging purpose. it is used to show what the line looked like before made any changes.
	# the substitue command's print flag differs from the print command in that it is conditional upon a successful subsitution.
	    #n print line before and after the changes.
		#	    /^\.Ah/{
		#	    p
		#	    s/"//g
		#	    s/^\.Ah //p
		#	}
	echo "this is a test" | sed 'p'
	sed -n '/number 3/p' data1.txt
	sed -n '2,3p' data1.txt
	# displays the line before it's changed
	sed -n '/3/{
	    p
	    s/line/test/p
	    }' data1.txt
    # printing line numbers
	sed '=' data1.txt
    # listing lines allowing to print text and nonprintable characters, showing nonprintable characters as two digit ASCII code.
	sed -n 'l' data1.txt
    # the n command outputs the contents of the pattern space and then read the next line of input without returning to the top of the script. in effect, the n command the next line of input to replace the current line in the pattern space. subsequent commands in the script are applied to the replacement line, not the current line. if the default output has not been suppressed, the current line is printed before the replacement takes place. Commands before the n command will not be applied to the new input line. nor will commands occuring after it be applied to the old line.
    # using file with sed
	# one use is to extract information from one file and place it in its own file. the advantage with sed it that we can break up the file into four separate files in a single step.
	    /Northeast$/w region.northeast
	    /South$/w region.South
	    /Midwest$/w region.Midwest
	    /West$/w region.West
	    # we may want to remove the name of the region before writing it to file. for each case, we could handle it as below:
	    /Northeast$/{
			s///
			w region.northeast
			}
	    # you could use it in a script to generate several customized versions of the same source file.
	# the quit command causes sed to stop reading new line input and stop sending them to the output.
	sed '1q' data1.txt
	sed '1,2w test.txt' data1.txt
	sed -n '1,2w test.txt' data1.txt
	sed '3r test.txt' data1.txt
	sed '/number 2/r test.txt' data1.txt
	echo teh Teh atehb | sed 's/\b\(t\)eh\b/\1he/ig' # word boundary subgroup back reference
	# the read command reads the contents of file into the pattern space after the addressed line.
	# you must have a single space between the command and the filename. (everything after the space and up to the newline is taken to be the filename.)
	sed '$r test.txt' data1.txt
	# a cool application of the read command is to use it in conjunction with a delete
	# to replace a placeholder in a file with data from another file
	# h copy pattern space to hold space
	# H append pattern space to hold space
	# g copy hold space to pattern space
	# G append hold space to pattern space
	# x exchanges
	# b branching: if label is not present, the b command proceeds to the end
	# t if the s command succeessfully matches, the t branches to a label, if label is not present, it branches to the end.
	# & the ampersand symbol is used to represent the matching pattern in s command
	# grouping substring: using parentheses in s command, use the escape character to identify them as grouping characters
	sed '/header/{n ; d}' data1.txt
	sed '/header/{n ; d}' data1.txt  | tail -n 4
	sed '/first/{N ; s/\n/ /}' data2.txt
	sed 'N ; s/system Administrator/Desktop User/' data2.txt
	sed 'N ; s/system.Administrator/Desktop User/' data2.txt
	sed 'N; /system\nAdm/d' data2.txt
	sed 'N; /system\nAdm/D' data2.txt
	sed -n 'N ; /system\nAdmi/P' data2.txt
	sed -n '/first/ { h; p; n; p; g; p}' data2.txt
	sed -n '{1!G; h; $p}' data2.txt
	sed '{2,3b ; s/this is/Is this/ ; s/line/test?/}' data2.txt
	sed '{/first/b jump1; s/this is the/No jump on/
	    :jump1
	    s/this is the/Jump here on/}' data2.txt
	echo "this, is, a, test, to, remove, commas." | sed -n '{:start
	    s/,//1p
	    /,/b start
	}'
	sed '{
	    s/first/matched/
	    t
	    s/this is the/No match on/
	}' data2.txt
	echo "this, is, a, test, to, remove, commas." | sed -n '{:start
	    s/,//1p
	    t start
	}'
	echo "ths cat sleeps in his hat." | sed 's/.at/"&"/g'
	echo "that furry cat is pretty" | sed 's/furry \(.at\)/\1/'
	echo "that furry hat is pretty" | sed 's/furry \(.at\)/\1/'
	# using substring components to insert a comma in long numbers
	echo "45657612345asd1234567" | sed '{
	    :start
	    s/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/
	    t start
	}'
    # [sed utilities]
	# spacing with double lines
	sed "G" data1.txt
	# insert two blank line
	sed 'G;G' data1.txt
	sed "$!G" data1.txt
	# spacing file with blanks, first delete existing blank lines
	sed '/^$/d; $!G' data1.txt
	# numbering lines in a file
	sed '=' data1.txt | sed 'N; s/\n/ /'
	# deleting consecutive blank lines
	# the key is to create an address range including a non-blank line and a blank line. if sed comes across this range, it shouldn't delete the line.
	sed '/./,/^$/!d' data1.txt
	# deleting leading blank lines
	sed '/./,$!d' data1.txt
	# deleting trailing blank lines
	# braces within normal script braces allow you to group commands together. the address pattern matches any line that contains only newline character. when found, if the last line, the delete command delete it. if not, the N append next line to it, and branch to the beginning.
	sed '{
	    :start
	    /^\n*$/{$d; N; b start}
	}' data1.txt
	# view a range of lines of a file
	sed -n '5,10p' setup.sh
	# view entire file except a given range
	sed '20,30d' setup.sh
	# view non-consecutive lines
	sed -n -e '5,7p' -e '10,13p' setup.sh
	# ignore character case
	sed 's/version/story/gi' setup.sh
	ip route show | sed 's/ */ /g'
	# in-place editing and backing up original file
	sed -i'.orig' 's/this/that/gi' data1.txt
	# switching pairs of words
	echo "white,Walter"  | sed 's/^\(.*\),\(.*\)$/\2, \1/g'
	# display starting with "Of course", ending with "attention"
	sed -n '/Of course/,/attention/p' myfile
	# write all commands in .sed and execute them
	sed -f script.sed file.txt
	# replace ham with cheese except 5th line
	sed '5!s/ham/cheese/' file.txt
	# delete last line
	sed '$d' file.txt
	# print lines with three consecutive digits
	sed '/[0-9]\{3\}/p' file.txt
	# unless boom found, replace  aaa with bb
	sed '/boom/!s/aaa/bb/' file.txt
	# delete all lines from line 17 to 'disk'
	sed '17,/disk/d' file.txt
	# replace foo with bar for the 4th instance
	sed 's/foo/bar/4'
	# delete every third line start from the first
	sed '1~3d' data1.txt
	# stop after printing the second line
	seq 3 | sed 2q

# [RegEX]
    # [general]
	    echo "this is a test" | sed -n '/test/p'
	    echo "this is a test" | sed -n '/trial/p'
	    echo "this is a test" | gawk '/test/{print $0}'
	    echo "\ is a special character" | sed -n '/\\/p'
	    echo "3 / 2" | sed -n '/\//p'
	    echo "this ^ is a test" | sed -n '/s ^/p'
    # [character classes]
	    echo "yes" | sed -n '/[Yy]es/p'
    # [special character classes]
	# [[:alpha:]] [[:alnum:]] [[:blank:]] [[:digit:]] [[:lower:]] [[:print:]] [[:space:]] [[:upper:]]
	    echo "abc124" | sed -n '/[[:alpha:]]/p'
	    echo "this is, a test" | sed -n '/[[:punct:]]/p'
	    echo "baeeaaet" | sed -n '/b[ae]*t/p'
    # ERE you can use in gawk
	# question mark: zero or one time
	    echo "bt" | gawk '/be?t/{print $0}'
	    echo "bet" | gawk '/be?t/{print $0}'
	    echo "beet" | gawk '/be?t/{print $0}'
	    echo "bt" | gawk '/b[ae]?t/{print $0}'
	    echo "bet" | gawk '/b[ae]?t/{print $0}'
	    echo "bat" | gawk '/b[ae]?t/{print $0}'
	    echo "beat" | gawk '/b[ae]?t/{print $0}'
	# plus sign: one or more times
	    echo "bat" | gawk '/b[ae]+t/{print $0}'
	    echo "baet" | gawk '/b[ae]+t/{print $0}'
	    echo "baeaeat" | gawk '/b[ae]+t/{print $0}'
	# braces: a limit on a repeatable regular expression
	    echo "bt" | gawk --re-interval '/be{1}t/{print $0}'
	    echo "bet" | gawk --re-interval '/be{1}t/{print $0}'
	    echo "beet" | gawk --re-interval '/be{1}t/{print $0}'
	# pipe symbol: in a logical OR formula
	    echo "The cat is asleep" | gawk '/cat|dog/{print $0}'
	    echo "The dog is asleep" | gawk '/cat|dog/{print $0}'
	# grouping expressions
	echo "Sat" | gawk '/Sat(urday)?/{print $0}'
	echo "Saturday" | gawk '/Sat(urday)?/{print $0}'
	echo $PATH | sed 's/:/ /g'
    # POSIX character classes
    [:alnum:] # alphanumberic characters
    [:alpha:] # alphabetic characters
    [:blank:] # space and tab characters
    [:cntrl:] # control characters
    [:digit:] # numeric characters
    [:graph:] # both printable and visiable
    [:lower:]
    [:print:] # printable characters
    [:punct:] # punctuation characters
    [:space:] # space
    [:upper:]
    [:xdigit:]
    # collating symbols multicharacter collating elements enclosed between '[.' and '.]'
    # awk (and POSIX) regex always match the leftmost, longest sequency of input characters that can match.
    echo aaaabcd | awk '{ sub(/a+/, "<A>"); print}'
    \s # match any whitespace, think of it as shorthand for [[:space:]]
    \S # match any character that is not whitespace.
    \w # match any word-constituent character -- that is, it matches any letter, digit, or underscore.
    \W # same as previous
    \< # matches the empty string at the beginning of a word. /\<away/
    \> # matches the empty string at the end of a word.
    \y # matches the empty string either beginning or end of a word (boundary)
    \B # matches the empty string that occurs between two word-constituent characters. /\Brat\B matches 'crate', but it does not match 'dirty rat', \B is essentially the opposite of \y.

# [awk]
    # case is normally significant in regex, both when matching ordinary characters and inside bracket expressions. One way to perform a case-insensitive match is to convert the data to a single case, using the tolower() or toupper() built-in string functions.
    # another method, specific to gawk, is to set the variable IGNORECASE to a nonzero value(predefined variable). Changing the value of IGNORECASE dynamically controls the case sensitivity of the program it runs
    x = "aB"
    if ( x ~ /ab/ ) ... # this will fail
    IGNORECASE = 1
    if ( x ~ /ab/ ) ... # this will succeed
    # on rare occasions, you may need to use the getline command. the getline command is valuable both because it can do explicit input from any number of files, and because the files used with it do not have to be named on the awk command line.
    FNR # which is reset to zero every time a new file is started. Another predefined variable NR records the total number of input records read so far from all datafiles. it starts at zero, but is never automatically reset to zero.
    # the new record-separator character should be enclosed in quotation marks, whihc indicate a string constant.
    # another way to change the record separator is on the command line, using the variable-assignment feature
    awk '{print $0}' RS="u" mail-list # this sets RS to 'u' before processing mail-list

    # awk reads files in units called records.records are automatically split into fields. by default, records are separated by newlines, fields are separated by whitespace. the awk execution cycle is over records.
    # $1 $2 this means concatenation, string join. awk '{ print $4"  "$3"\t\t"$2$1 }'
    # patterns in awk serve the same function as addresses in sed. Patterns specified before the beginning of a block. BEGIN and END. Patterns can be: any expression that return a value (different from sed), a regex, a range of the form expr1, expr2. if we use regex, just like sed, awk executes the block for any record that matches the regex. as soon as awk finishes the begin block, it will start reading input from file.
    # to print only lines that begin with character #
    cat cheatsheet.sh | awk '/^#/{ print }'
    # a pattern is negated by preceeding it with a  !
    cat cheatsheet.sh | awk '! /^#/{ print }'
    # awk has certain variables whose values are dynamically set by awk itself.
	# NF number of fields: this numbers can be changed, eg: 3 fields in first line, 4 fields in second line.
	# NR number of records: in our case, it is line number.
	cat cheatsheet.sh | awk 'NR % 2 == 0 {print}'
	cat cheatsheet.sh | awk '$1 == "C" { print }'
	# when the awk sees the slash '/', it knows it is regex.  if no slask, it is line expression, such 2 is line expression, returning 2 which is true.
	# range operation: two regex, or one regex, another is line expression.
	cat cheatsheet.sh | awk '/^C/,/^N/ { print }'
	cat cheatsheet.sh | awk '/^C/,NR==7 { print }'
	# by default awk considers each line as a record. and, each space separated word of a line as a field. that is: the newline character is the record separator, whitespace is the field separator. The FS and RS variables allow us to modify this behavior.
	#parsing mbox text
	cat mbox | awk 'BEGIN{RS = "\n\nFrom "; FS = "\n"}
	NR == 2{ print }'
	# climateData
	cat monthlyPDI.txt | awk 'BEGIN { tot=0 } {
	    tot = tot + $2 } NR%12 == 0{ print tot/12; tot = 0 }' | wc -l
	echo $((503/12))
	# when you use uninitialized variable, the value is 0. So the BEGIN block is unnecessary.
	cat monthlyPDI.txt | awk '{ tot = tot + $2 }'
	# in awk ducoment, you can have address or action, but you can obmit any one of them
	# address and or action block NR==7 is equal to NR==7{ print }
	# null strings are removed when they occur as part of a nono-null command line argument, while explicit null objects are kept.
	awk -F "" 'program' files # correct
	# don't use this:
	awk -F"" 'program' files # wrong!
	# a  fourth option is to use command-line variable assignment,
	awk -v sq="'" 'BEGIN { print "here is a single quote <" sq ">"}'
	# if your really need both single and double quotes in your awk program, it is probably best to move it into a separate file.
	# in a awk rule, either the pattern or the action can e omitted, but not both. if pattern omitted, then the action is performed for every input line. if action omitted, the default action is to print all lines that match the pattern. By comparison, omitting the print statement but retaining the braces makes an empty action that does noting (i.e., no lines are printed).
	# print every line that is longer than 80 characters
	awk 'length($0) > 80' cheatsheet.sh # the sole rule has a relation expression as its pattern and has no action.
	awk '{ if (length($0) > max ) max = length($0)}
	    END{ print "maximun line length is " max}' cheatsheet.sh
	# print every line that has at least one field
	awk 'NF > 0 ' data1.txt
	# print a sorted list of the login names of all users:
	awk -F: '{print $1}' /etc/passwd | sort
	# count the lines in a file
	awk 'END{print NR}' data1.txt
	awk 'NR % 2 == 0' data1.txt
	ls -l | awk '$6 == "Feb" { sum += $5 }
		END { print sum}'
	# the -f option may be used more than once. awk reads its program source from all of the named files, as if they had been concatenated together into one big file. This is useful for creating libraries of awk functions. these functions can be written once and then retrieved from a standard place. the -i option is similar in this regard. Because it is clumsy using awk to mix source file and commandline, gawk provides the -e option. it allows you to easily mix commandline and library source code. it can be used multiple times on commandline.
	# an argument that has the form var=value, assigns the value to the variable var -- it does not specify a file at all.
	awk -f program.awk file1 count=1 file2 # all the commandline arguments are made available to your awk program in the ARGV array.
	# the distinction between filename arguments and variable-assignment arguments is made when awk is about to open the next input file. In particular the values of variables assigned in this fashion are not available inside a BEGIN rule.
	# Naming standard Input
	some_command | awk -f myprog.awk file1 - file2 # here awk first reads file1, then it reads the output of some_command, and finally it reads file2.
	# with gawk, if filename supplied to -f or -i options does not contain a directory separator '/', then gawk searches a list of directories one by one, looking for a file with the specified name. the search path is a string consisting of directory names separated by colons. gawk gets its search path from the AWKPATH environment path. The library files can be placed in a standand directory in the default path and specified on the command line with a short filename. if the source file is not found after the initial search, the path is searched again after adding the suffix '.awk'to the filename.
	# ^ matches the beginning of a string. It is important to realize that '^' doesn't match the beginning of a line (the point right after a '\n ' newline character) embedded in a string.. The condition is not true in the following example: 
	if ("line1\nLINE 2" ~ /^L/) ...
	# after the end of the record has been determined, gawk sets the variable RT to the text in the input that matched RS. When RS is a single character, RT contains the same single character. However, when RS is a regular expression, RT contains the actual input text that matched the regular expression.
	echo record 1  AA     record 2 BB record 3 |
	gawk 'BEGIN { RS = "\n|( *[[:upper:]]+ *)"}
		{print "record =", $0, "and RT = [" RT "]"}'
	# the square brackets delineate the contents of RT, letting you see the leading and trailing whitespace. the final value of RT is a newline. gawk views the input file as one long string that happens to contain newline characters. it is thus best to avoid anchor metacharacters in the value of RS.
	# NF is a predefined variable whose value is the number of fields in the current record. awk automatically updates the value of NF each time it reads a record. No matter how many fields there are, the last field in a record can be represented by $NF.
	# using expressions as field numbers:
	awk '{ print $(2*2)}' data1.txt # awk evaluates the expression (2*2) and uses its value as the number of the field to print.

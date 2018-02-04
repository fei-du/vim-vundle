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
    # math equation $[1+ 5] supports only integer arithmetic
    # exit status codes can only go up to 255
    # double parentheses allows to incorporate advanced mathematical formulas, and assigning values
    # subshell $()
    # double brackets for string comparisons: pattern matching
    # bash shell automatically gives error messages a higher priority than the standard output.
    # use subshell to capture the output of a function to a shell variable
    # variable defined in function is global, unless use local keyword.
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

# [git]
    # check whether remote has changed
    git ls-remote origin -h refs/heads/master
    # Generate diffs with <n> lines of context instead of the usual three
    git diff  -U10 clock_config.c

# [sed]
    # sed conforms only to a subset of the BRE for the speed
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
	sed '2,3d' data1.txt
	sed '/number 1/d' data1.txt
    # inserting and appending text
	echo "test line 2" | sed 'i\test line 1'
	echo "test line 2" | sed 'a\test line 1'
	sed '$a\
	    This is a new line of test' data1.txt
	sed '1i\
	    this is one line of text.\
	    this is another line of new text.' data1.txt
    # changing lines
	sed '3c\
	    this is a changed line of text'  data1.txt
	sed '/number 3/c\
	    this is a changed line of text'  data1.txt
    # transforming characters: performing a one to one mapping of the inchars and outchars
	sed 'y/1234/6789/' data1.txt
    # printing lines
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
    # listing lines allowing to print text and nonprintable characters
	sed -n 'l' data1.txt
    # using file with sed
	sed '1,2w test.txt' data1.txt
	sed -n '1,2w test.txt' data1.txt
	sed '3r test.txt' data1.txt
	sed '/number 2/r test.txt' data1.txt
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

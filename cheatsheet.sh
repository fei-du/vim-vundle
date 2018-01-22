#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

[find]
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

[grep]
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

[tar]
    # tar function [options] object1 object2
    tar -cvf a.tar gitconfig setup.sh
    tar -tf a.tar
    tar -xvf a.tar

[option]
    getopt ab:cd -a -b test1 -cd test2 test4
    getopt ab:cd -a -b test1 -cde test2 test4
    getopt -q ab:cd -a -b test1 -cde test2 test4

[xargs]
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

[misc]
    # without the dollar sign, the shell interprest the variable name as a normal text string
    # math equation $[1+ 5] supports only integer arithmetic
    # exit status codes can only go up to 255
    # double parentheses allows to incorporate advanced mathematical formulas, and assigning values
    # subshell $()
    # double brackets for string comparisons: pattern matching
    # bash shell automatically gives error messages a higher priority than the standard output.
    # use subshell to capture the output of a function to a shell variable
    # variable defined in function is global, unless use local keyword.

[sed]
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

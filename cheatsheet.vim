"[power of g]
    " brief explanation of :g
    :[range]g/pattern/cmd
    " default whole file, by executing Ex command for each line matching pattern. before executing, "." is set to the current line
    " delete all lines containing a pattern
	:g/profile/d
	:g/^\s*$/d "delete empty or containing whitespace
	"delete all lines that are not comment lines in ivm script
	:g!/^\s*"/d
	" g! is equivalent to v
	:v/^\s*"/d
	" example of use \| ("or") to delete all lines except those containing "error" "warn" "fail"
	:v/error\|warn\|fail/d
    " display context (5 lines) for all occurences of a pattern
	:g/pattern/z#.5
	" same, but with some beautification
	:g/pattern/z#.5|echo "======="
	" double space the file
	:g/^/pu =\"\n\"
	" alternative (:put inserts nothing from the blackhole register
	:g/^/pu _
	" copy all matching lines to end of file
	:g/pattern/t$
	:g/pattern/m$
	" copy all matching lines to register 'a'
	qaq:g/pattern/y A
	" increment each number at the start of a line, from current to end-of-file by one
	:.,$g/^\d/exe "normal! \<C-A>"
	" comment lines containing DEBUG statements in a C program
	:g/^\s*DEBUG/exe "normal! I/* \<Esc>A */\<Esc>"
	" using :substituting
	:g/^\s*DEBUG/s!.*!/* & */!
	" reverse a file
	:g/^/m0
	" add text to the end of a line that begin with a certain string
	:g/^pattern/s/$/mytext
	:g/pattern/d_
	:2,8co15 "copy line 2 through 8 after line 15
	:4,15t$ "copy lines 4 through 15 to end of document
	:-t$ "copy previous line to end of document
	:m0 "move current line to line 0
	:.,+3m$-1 "current line through current+3 are moved to the lastline-1
	:help :k
	:help ex-cmd-index "provides a list of Ex command
	:help 10.4 "is the section of user manual discussing the :global command
	:help multi-repeat "talks about both the :g and :v commands
	" over a range defined by a and b, operate on each line containing pattern, the operation is to replace each pattern2 with string
	:`a,`bg/pattern/s/pattern2/string/gi
	" run a macro on matching lines
	:g/pattern/normal @q

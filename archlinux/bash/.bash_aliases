# Pacman alias examples
alias :pacup='sudo powerpill -Syu && dkmsup' # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias :pacin='sudo powerpill -S'			# Install specific package(s) from the repositories
alias :pacpk='sudo powerpill -U'			# Install specific package not from the repositories but from a file
alias :pacrm='sudo powerpill -Rnsc'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias :pacls="powerpill -Ql"			# List all files installed by a given package
alias :pacown="powerpill -Qo"			# Show package(s) owning the specified file(s)
alias :pacremi='powerpill -Si'			# Display information about a given package in the repositories
alias :pacrems='powerpill -Ss'			# Search for package(s) in the repositories
alias :pacloci='powerpill -Qi'			# Display information about a given package in the local database
alias :paclocs='powerpill -Qs'			# Search for package(s) in the local database
alias :pacorph="powerpill -Qdtq"			# List all packages which are orphaned
alias :pacexpl="powerpill -D --asexp"		# Mark one or more installed packages as explicitly installed
alias :pacimpl="powerpill -D --asdep"		# Mark one or more installed packages as non explicitly installed
alias :pacprune="sudo paccache -r"		# Clean cache - delete all the package files in the cache
alias :pacclean="sudo paccache -ruk0"		# Clean cache - delete all the package files in the cache
alias :paccleanall="sudo paccache -rk0"		# Clean cache - delete all the package files in the cache

# Additional powerpill alias examples
alias :pacindeps='sudo powerpill -S --asdeps'    # Install given package(s) as dependencies

# convenience
alias :c="clear"
alias :di="docker images"
alias :dp="docker ps -a"
alias :drmin="docker images | grep '<none>' | tr -s ' ' | cut -f 3 -d ' ' | xargs -r docker rmi"
alias :e="vim -p"
alias :g="echo -e '\nBRANCHES' && git branch && echo -e '\nLATEST' && git log -n 1 && echo -e '\nSTATUS' && git status -sb && echo"
alias :h="python -m SimpleHTTPServer 8888 2> /dev/null"
alias :q="exit"
alias :r="rm -f *.swp *.swo .*.swp .*.swo *.pyc *.pyd"
alias :s='sudo $(history -p \!\!)'  # single quotes are important
alias :w="git add . && git commit -m"
alias gbc='go install bitbucket.org/remeeting/mrp-go/goconv' # single quotes
alias gbf='go install --ldflags --extldflags=--static bitbucket.org/remeeting/mrp-go/gofex'
alias gbg='env CGO_LDFLAGS="-L$GOPATH/src/bitbucket.org/remeeting/mrp-go/lib/ -lopenblas -lm" go install --ldflags --extldflags=--static bitbucket.org/remeeting/mrp-go/gogmm'
alias total="awk '{sum += \$1} END {print sum}'"

# cd's
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

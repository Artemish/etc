shared_var() {
    . ~/.sh/shared_cache

    if [ $# -eq 0 ]; then
        echo "Usage: s <var> [value]"
        return 1
    elif [ $# -eq 1 ]; then
        eval _X_=\$"$1"
        sed -i "" "/export ${_X_}=/ d" ~/.sh/shared_cache
        echo "${_X_}"
    elif [ $# -eq 2 ]; then
        echo "export ${1}='${2}'" >> ~/.sh/shared_cache
    fi
}

shared_file() {
    . ~/.sh/shared_cache

    if [ $# -eq 0 ]; then
        echo "${_f_}"
    elif [ $# -eq 1 ]; then
        sed -i "" '/export _f_=/ d' ~/.sh/shared_cache
        echo "export _f_='$(realpath "${1}")'" >> ~/.sh/shared_cache
    fi
}

alias sf='shared_file'
alias s='shared_var' 

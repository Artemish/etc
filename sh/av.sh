av() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: av <ag args>" 2>&1
        return 1
    fi

    file=$(ag -l "$@" | selecta)
    specific=$(ag --vimgrep --noheading "$@" "${file}" | selecta)

    vim "${file}:$(echo "$specific" | cut -d : -f2)"
}

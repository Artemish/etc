includes() {
    grep -E "^#include" "$@"
}

argn() { echo $#; }

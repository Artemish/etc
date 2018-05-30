includes() {
    egrep "^#include" "$@"
}

argn() { echo $#; }

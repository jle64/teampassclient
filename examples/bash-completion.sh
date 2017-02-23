_teampass() {
        local cur
        cur=${COMP_WORDS[COMP_CWORD]}
        IFS=$'\n'
        COMPREPLY=( $( compgen -W "$( teampass list )"-- $cur ) )
        return 0
}
complete -F _teampass teampass

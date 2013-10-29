#xm completion function
function _xm()
{
    local word=${COMP_WORDS[COMP_CWORD]}
    local line=${COMP_LINE}
    local comstr="console\ncreate\ndestroy\ndomid\ndomname\ndump-core\nlist\nmem-max\nmem-set\nmigrate\npause\nreboot\nrename\nrestore\nsave\nshutdown\nsysrq\ntrigger\ntop\nunpause\nuptime\nvcpu-list\nvcpu-pin\nvcpu-set\ndebug-keys\ndmesg\ninfo\nlog\nserve\nsched-credit\nsched-sedf\nblock-attach\nblock-detach\nblock-list\nblock-configure\nnetwork-attach\nnetwork-detach\nnetwork-list\nvtpm-list\npci-attach\npci-detach\npci-list\npci-list-assignable-devices\nvnet-list\nvnet-create\nvnet-delete\nlabels\naddlabel\nrmlabel\ngetlabel\ndry-run\nresources\nmakepolicy\nloadpolicy\ncfgbootpolicy\ndumppolicy"
    local Wordlist
    local Wordlist1
    local Wordlist2

    case "$line" in
        *create*)
            COMPREPLY=($(compgen -f -X "!*.cfg" -- "${word}"))
            ;;
        *console*|*destroy*|*reboot*|*pause*|*unpause*|*shutdown*|*mem-max*|*mem-set*|*uptime*|*vcpu-list*|*vcpu-set*|*block-attach*|*block-detach*|*block-list*|*network-attach*|*network-detach*|*network-list*|*pci-attach*|*pci-detach*|*vcpu-pin*|*rename*|*domid*|*migrate*)
            Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *pci-list-assignable-devices*)
            Wordlist1=$(xm pci-list-assignable-devices|grep -iv error)
            COMPREPLY=($(compgen -W "$Wordlist1" -- "${word}"))
            ;;
        *pci-list*)
            case "${line/*pci-list/}" in
                *" "*)
                    Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
                    COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
                    ;;
                "")
                    Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
                    COMPREPLY=($(compgen -W "$Wordlist2 pci-list-assignable-devices" -- "${word}"))
                    ;;
            esac
            ;;
        *list*)
            Wordlist2=$(xm list|sed '1,2d'|awk '{print $1}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *domname*)
            Wordlist2=$(xm list | sed '1,2d' | awk '{print $2}')
            COMPREPLY=($(compgen -W "$Wordlist2" -- "${word}"))
            ;;
        *dry-run*)
            COMPREPLY=($(compgen -f -X "!*.cfg" -- "${word}"))
            ;;
        *restore*|*save*)
            COMPREPLY=($(compgen -f -- "${word}"))
            ;;
        *)
            Wordlist=$(
            ls *.cfg 2>/dev/null
            echo -e "$comstr"
            )
            COMPREPLY=($(compgen -W "$Wordlist" -- "${word}"))
            ;;
    esac
}

#install profile have include this
complete -o default -F _xm xm

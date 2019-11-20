#!/bin/bash

function rpstack()
{
    if [ $# == 0 ]; then
        echo "pstack <pid>"
        return
    fi
    gdb --quiet -batch \
        -ex "echo \n===========BT===========\n" -ex bt \
        -ex "echo \n======INFO THREADS======\n" -ex "info threads" \
        -ex "echo \n=======THREAD BT========\n" -ex "thread apply all bt" \
        -p $1
}

function rptask()
{
    if [ $# == 0 ]; then
        echo "rptask <pid>"
    fi
    if [ "$2" == "-v" ];then
        ps -To pid,tid,tgid,tty,time,comm -p $1
    else
        ps -T -p $1
    fi
}

function rpram()
{
    free
}

function rpmap ()
{
    if [ $# == 0 ]; then
        echo "rptask <pid>"
    fi
    pmap -x $1
}

function rpstrace()
{
    if [ $# == 0 ]; then
        echo "rptask <pid>"
    fi
    strace -p $1
}



function rphelp()
{
    echo "rptask <pid>    - "
    echo "rpstack <pid>   - "
    echo "rpstrace <pid>  - "
    echo "rpmap <pid>     - pmap command displays the memory map of a given process. You need to pass the pid as an argument to the pmap command.\n"
    echo "rpram           - Free command displays information about the physical (RAM) and swap memory of your system.\n"
}

function rpread()
{
    echo "https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/developer_guide/debugging-running-application"
    echo "https://www.thegeekstuff.com/2011/12/linux-performance-monitoring-tools/"
}

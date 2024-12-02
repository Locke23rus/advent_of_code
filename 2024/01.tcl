#!/usr/bin/env tclsh

proc readlines {file} {
    set fd [open $file r]
    set lines [split [read -nonewline $fd] \n]
    close $fd
    return $lines
}

set lines [readlines "input/01.txt"]

set part1 0
set part2 0

set leftList {}
set leftList {}

foreach line $lines {
    set pair [split $line]
    lappend leftList [lindex $pair 0]
    lappend rightList [lindex $pair end]
}

set leftListSorted [lsort -integer $leftList]
set rightListSorted [lsort -integer $rightList]

foreach left $leftListSorted right $rightListSorted {
    if {$left > $right} {
        set part1 [expr {$part1 + $left - $right}]
    } else {
        set part1 [expr {$part1 + $right - $left}]
    }
}

foreach left $leftListSorted {
    set matches [lsearch -all $rightListSorted $left]
    set part2 [expr {$part2 + $left * [llength $matches]}]
}

# puts $lines
# puts "leftList: $leftList"
# puts "leftListSorted: $leftListSorted"
# puts "rightList: $rightList"
# puts "rightListSorted: $rightListSorted"
puts "Part 1: $part1"
puts "Part 2: $part2"

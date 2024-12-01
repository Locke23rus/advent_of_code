proc readlines {file} {
  set fd [open $file r]
  set lines [split [read -nonewline $fd] \n]
  close $fd
  return $lines
}

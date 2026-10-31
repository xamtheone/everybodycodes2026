#!/usr/bin/env nu
def main [file] {
    open -r $file
    | lines 
    | split column " " left right
    | each {|row|
        let left = $row.left | str replace "ISO-" "" | split chars | each { into int }
        let right = $row.right | split chars | each { into int }
        let l = $row.right | str length
        mut s = 0
        for $i in ..<$l {
            let a = $right | get $i
            let b = $left | get $i
            let e = $l - $i - 1
            $s += $a * $b ** $e
        }
        $s
    }
    | math sum
}
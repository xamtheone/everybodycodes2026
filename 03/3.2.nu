#!/usr/bin/env nu
def main [file] {
    open -r $file
    | lines 
    | split column " " left right
    | each {|row|
        let left = $row.left | str replace "ISO-" "" | split chars | reverse | each { into int }
        let right = $row.right | split chars | reverse | each { into int }
        let l = $row.right | str length
        mut s = 0
        for $i in ..<$l {
            let a = $right | get $i
            let b = $left | get ($i mod ($left | length))
            let e = $i
            $s += $a * $b ** $e
        }
        $s
    }
    | math sum
}
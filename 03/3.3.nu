#!/usr/bin/env nu
def main [file] {
    open -r $file
    | lines 
    | split column " " left right
    | each {|row|
        let left = $row.left | str replace "ISO2-" "" | split chars | reverse | each { into int }
        let x = ($row.right | into int) - 1
        let original = number $left $row.right
        mut use = true
        for $t in $x..0 {
            let lesser = number $left ($t | into string)
            if $lesser == $original {
                $use = false
                break 
            }
        }

        if $use {
            $original
        }
        
    }
    | math sum
}

def number [left, strright] {
    let right = $strright | split chars | reverse | each { into int }
    let l = $strright | str length
    mut s = 0
    for $i in ..<$l {
        let a = $right | get $i
        let b = $left | get ($i mod ($left | length))
        let e = $i
        $s += $a * $b ** $e
    }
    $s
}
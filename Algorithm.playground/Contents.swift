//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
println(str)



func binarySearch<T: Comparable>(arr: [T], target: T) -> Int {
    var l = 0
    var u = arr.count - 1
    var m: Int
    while(l <= u) {
        m = (l + u) / 2
        if(target == arr[m]) {
            return m
        } else if(target > arr[m]) {
            l = m + 1
        } else {
            u = m - 1
        }
    }
    return -1
}

func binarySearchFirst<T: Comparable>(arr: [T], target: T) -> Int {
    var l = -1
    var u = arr.count
    var m: Int
    while(l + 1 != u) {
        m = (l + u) / 2
        if(arr[m] < target) {
            l = m
        } else {
            u = m
        }
    }

    var r: Int = u
    if (r >= arr.count || arr[r] != target) {
        r = -1
    }
    return r
}

func linearSearch<T: Comparable>(arr: [T], target: T) -> Int {
    for (index, value) in enumerate(arr) {
        if value == target {
            return index
        }
    }
    return -1
}

var A = [0,1,2,3,4,5,6,7,8,9]
var B = [Int]()
var C = [0,1,2,3,4,5,6,9,9,9]
var D = [9,9,9,9,9,9,9,9,9,9]
var t = 9
binarySearch(A, t)
binarySearch(B, t)
linearSearch(A, t)
linearSearch(B, t)
binarySearchFirst(A, t)
binarySearchFirst(C, t)
binarySearchFirst(D, t)


func swap(inout x: [Int], i: Int, j: Int) {
    var t = x[i]
    x[i] = x[j]
    x[j] = t
}

func insertSort(inout arr: [Int]) -> [Int] {
    var j: Int
    for var i = 1; i < arr.count; i++ {
        t = arr[i]
        for j = i; j > 0 && arr[j-1] > t; j-- {
            arr[j] = arr[j-1]
        }
        arr[j] = t
    }
    return arr
}

func selectSort(inout x: [Int]){
    var n = x.count - 1
    for i in 0...n {
        for j in i...n {
            if x[j] < x[i] {
                swap(&x, i, j)
            }
        }
    }
}

func shellSort(inout x: [Int]){
    var n = x.count
    var h: Int
    for h = 1; h < n; h = 3 * h + 1 {}
    println(h)
    while true {
        h /= 3
        if h < 1 {break}
        for i in h...n-1 {
            for var j = i; j >= h; j -= h {
                if x[j-h] < x[j] {break}
                swap(&x, j-h, j)
            }
        }
    }
}

func quickSort(inout x: [Int], l: Int, u: Int){
    if l >= u {
        return
    }
    var t = x[l]
    var i = l
    var j = u + 1
    while true {
        do {i++} while i <= u && x[i] < t
        do {j--} while x[j] > t
        if i >= j {
            break
        }
        swap(&x, i, j)
    }
    swap(&x, l, j)
    println(j )
    println(x)
    quickSort(&x, l, j - 1)
    quickSort(&x, j + 1, u)
}

func selectk(inout x: [Int], l: Int, u: Int, k: Int){
    if l >= u {
        return
    }
    var t = x[l]
    var i = l
    var j = u + 1
    while true {
        do {i++} while i <= u && x[i] < t
        do {j--} while x[j] > t
        if i >= j {
            break
        }
        swap(&x, i, j)
    }
    swap(&x, l, j)
    if j < k {
        selectk(&x, j + 1, u, k)
    } else if j > k {
        selectk(&x, l, j - 1, k)
    }
}


var E = [5,1,1,4,5,8,3,7,0,9,8,2,3,5,6,2,3,0]
//insertSort(&E)
//selectSort(&E)
quickSort(&E, 0, E.count - 1)
//quickSort(&D, 0, D.count - 1)
//shellSort(&E)
//println(E)
E = [5,1,1,4,5,8,3,7,0,9,8,2,3,5,6,2,3,0]
selectk(&E, 0, E.count - 1, 9)


arc4random_uniform(UInt32(RAND_MAX))
UInt32(RAND_MAX)

func genknuth(var m: Int, n: Int){
    for var i = 0; i < n; i++ {
        var rand = Int(arc4random_uniform(UInt32(n)))
        if rand % (n - i) < m {
            print(rand)
            print(", ")
            m--
            if m == 0 {
                break
            }
        }
    }
    println()
}
genknuth(10, 100)



class Heap {
    var n: Int = 0
    var x: [Int] = [0]
    
    func siftup(m: Int) {
        var i = m
        var p = i/2
        for ( ; i > 1 && x[p] > x[i]; i=p, p=i/2) {
            swap(&x, p, i)
        }
    }
    
    func siftdown(m: Int) {
        var i = 1
        var c = 2 * i
        for ( ; c <= m; i=c, c=2*i) {
            if c + 1 <= m && x[c+1] < x[c] {
                c++
            }
            if x[i] <= x[c] {
                break
            }
            swap(&x, c, i)
        }
    }
    
    func insert(t: Int) {
        x.append(t)
        n++
        siftup(n)
    }
    
    func extractmin() -> Int {
        var t  = x[1]
        x[1] = x[n]
        x.removeLast()
        n--
        siftdown(n)
        println(x)
        return t
    }
}
var heap = Heap()
heap.insert(5)
heap.insert(10)
heap.insert(6)
heap.insert(1)
heap.extractmin()
heap.extractmin()



// Playground - noun: a place where people can play

import UIKit

// variable 変数 变量
var str = "Hello, playground"
println(str)

// constant 定数 常量
let tax = 1.08

// data type 型 类型
var str1 = "1 + 1"
var str2 = "1" + "1"
var num1 = 1 + 1
var double1 = 10.0
var bool1 = 1 == 1

var num2:Int = 3
let pi:Double = 3.14

// for 繰り返し (statement and block) 循环
for n in 1...3 {
    for m in 1...3 {
        println(m * n)
    }
}

// if
var batteryRemaining = 18
if batteryRemaining <= 5 {
    println("Battery remains \(batteryRemaining)% !!!")
} else if batteryRemaining <= 20 {
    println("Battery remains \(batteryRemaining)% !")
} else {
    println("Battery remains \(batteryRemaining)%")
}

// switch
var x = 1
switch x {
case 0:
    println("0");
case 1:
    println("1");
default:
    println("-1");
    
}

// while
var i = 5
while i < 5 {
    i = i + 1
}

// array 配列 数组
var arr = ["one", "two", "three"]
println(arr[0])
arr[0] = "zero"
arr.append("four")
arr.removeAtIndex(1)
println(arr)

for val in arr {
    println(val)
}

// dictionary 辞書 词典
var dict = [
    "one":"一",
    "two":"二",
    "three":"三",
]
println(dict["one"])
dict["four"] = "四"
dict["two"] = nil
println(dict)

// function 関数 函数
// parameter 引数 参数
// return value 戻り値 返回值
func areaOfTriangle1(base:Int, height:Int) -> Int {
    var result = base * height / 2
    return result
}
var area = areaOfTriangle1(3, 4)

// internal parameter & external parameter 内部引数名と外部引数名
func areaOfTriangle2(withBase base:Int, andHeight height:Int) -> Int {
    return base * height / 2
}
area = areaOfTriangle2(withBase: 4, andHeight: 5)

func areaOfTriangle3(#base:Int, #height:Int) -> Int {
    return base * height / 2
}
area = areaOfTriangle3(base: 5, height: 6)

// class クラス 类
var slider = UISlider()
slider.value = 1.0
slider.setValue(0.5, animated: true)

class Taiyaki {
    var nakami = "あんこ"
    func sayNakami(){
        println("中身は" + nakami + "です。")
    }
}
var taiyaki = Taiyaki()
taiyaki.nakami = "クリーム"
taiyaki.sayNakami()







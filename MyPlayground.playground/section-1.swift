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

// inheritance 継承(けいしょう) 继承
// override オーバーライド 重写
class Car {
    var distance = 0
    func stop() {
        println("stopped!")
    }
}

class SportsCar: Car {
    func drive() {
        distance += 10
    }
    override func stop() {
        print("SportsCar ")
        super.stop()
    }
}

class Trunk: Car {
    func drive() {
        distance += 5
    }
}

var sportsCar = SportsCar()
sportsCar.drive()
sportsCar.stop()

// class method 
class ClassMethod {
    class func classMethod() {
        println("This is class method")
    }
}

// nil オプショナル型
var age1:Int? = nil
age1 = 25
println(age1! + 1)   //println(age1 + 1) error

var age2:Int!        //var age2:Int! = nil
age2 = 25
println(age2 + 1)

// closure クロージャ 闭包
//{() -> Void in
//    println("closure")
//}
//{println("closure")}

//{(base: Int, height: Int) -> Int in
//    let area = base * height / 2
//    return area
//}

// protocal プロトコル 协议
protocol KyotoProtocol {
    func stopGlobalWarming()
}

@objc protocol KyotoProtocol2 {
    func stopGlobalWarming()
    optional func chargeCarbonTax()
}

class Japan: KyotoProtocol2 {
    @objc func stopGlobalWarming() {
        println("use green energy")
        println("plant forest")
    }
}

var country: KyotoProtocol2 = Japan()
var country2: protocol<KyotoProtocol, KyotoProtocol2>

// enumeration 列挙(れっきょ)体 枚举
enum Week {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

var today = Week.Monday
var tomorrow: Week = .Tuesday

enum Week2 : Int {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

println(Week2.Sunday.rawValue)

// delegate デリゲート 代理
protocol LawyerLicense {
    func defend()
}

class Lawyer: LawyerLicense {
    func defend() {
        println("defend!")
    }
}

class Defender {
    //var delegate2: Lawyer?
    var delegate: LawyerLicense?
}

let taro = Defender()
taro.delegate = Lawyer()
taro.delegate?.defend()




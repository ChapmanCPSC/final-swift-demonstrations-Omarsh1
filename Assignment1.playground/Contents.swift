//: Playground - noun: a place where people can play

import UIKit


                                                        //Optionals

//Declaring an optional Int
var someInt : Int? = nil
//Or
var someDouble : Optional<Double>
//Or an implicitly unwrapped optional
var someString : String!

someInt.dynamicType
someDouble.dynamicType
someString.dynamicType


//Function that returns an optional
func returnSomeOpInt(someIntInput : Int?) -> Int{ //Takes in an input that's an optional
    if(someIntInput != nil){
        return (someIntInput!)//returns the input unwrapped
    }
    else{
        print("Yo that's nil...")
        return(-1)
    }
}

//Function tests
someInt = 0;//Optional SomeInt is now 0
returnSomeOpInt(someInt)//Goes to if statement in function, unwraps then returns
someInt = nil;//Optional SomeInt is now nil
returnSomeOpInt(someInt)//Goes to else statement in function because input was nil

//However unwrapping someInt would result in an error because it's nil
// this is why the function does not return it's value when it's nil
//print(someInt!)

//Setting optional someDouble to nil
someDouble = nil
//someDouble!.isZero//Unwrapping someDouble and checking if == 0, causes error because it unwraps to nil
someDouble?.isZero //Safer way to do this^, conditionally unwraps//So if != to nil then unwrap
someDouble = 0
someDouble!.isZero//Works after someDouble has an actual value that's not nil

//Comparing non optional and optional
var someNonOptionalDouble = 0.0
someDouble == someNonOptionalDouble

func returnTheImplicitString(someString : String) -> String{
    return someString //no need to unwrap, since i'm gonna use it with implicitly unwrapped
}

//returnTheImplicitString(someString) //See now that we have an implicitly unwrapped optinal we don't
//have to unwrap every time we wanna use it and in function above^, i am expecting a normal String not String?
// this still returns an error though because someString is nil

someString = "whateverrrrrr"
returnTheImplicitString(someString)

                                                        //Object Types
//Classes
class City{
    //Class city has population and name
    var population : Int
    var cityName : String
    var buildingsList : [Building] //Class Building declared later below
    var numOfBuildings : Int
    
    //Intitializer for City
    init(theInitPop : Int, cityName: String ){
        population = theInitPop
        self.cityName = cityName
        buildingsList = []
        numOfBuildings = 0
    }
    //Convenience initializer
    convenience init(){
        self.init(theInitPop: 0, cityName: "")
        buildingsList = []
        numOfBuildings = 0
    }
    func addABuilding (aBuilding : Building...){
        for building in aBuilding{
            buildingsList.append(building)
            numOfBuildings++
        }
    }
    //Other classes can be declared within the same class
    //Cities have buildings
    class Building{
        //Building has height
        var buildingHeight : Int = 0;
        //We can declare another class that extends Building
        class Restaurant : Building{
            //Restaurant has number of chefs and restaurant type
            //Creating enum restaurantType within the class
            enum restaurantType : String {
                case American = "American"
                case Italian = "Italian"
                case Other = "Other"
                case Unknown = "Unknown"
                //Mutating function used to manipulate value of self
                mutating func restaurantSold(){
                    self = restaurantType(rawValue: "Unknown")!
                }
            }
            var theRestaurantType : restaurantType
            var numOfChefs : Int
            //Ovveriding the init method in building
            override init(){
                theRestaurantType = restaurantType.Unknown
                numOfChefs = 0
            }
        }
    }
}

//Using the classes we made, we'll declare new instances as such:
//New city using conv init
var Orange  = City()
Orange.cityName
Orange.population
Orange.buildingsList
Orange.numOfBuildings
//New city normal init
var Orange2 = City(theInitPop: 379874, cityName: "Orange")
Orange2.cityName
Orange2.population
Orange2.buildingsList
Orange2.numOfBuildings
//New building
var aChapmanBuilding =  City.Building()
aChapmanBuilding.buildingHeight = 1033
//New restaurant
var theFillingStation = City.Building.Restaurant()
theFillingStation.theRestaurantType
theFillingStation.numOfChefs
theFillingStation.buildingHeight

theFillingStation.theRestaurantType = City.Building.Restaurant.restaurantType.American
theFillingStation.numOfChefs = 5
theFillingStation.buildingHeight = 42

Orange2.addABuilding(aChapmanBuilding, theFillingStation)
Orange2.buildingsList
Orange2.numOfBuildings


//So now
theFillingStation.theRestaurantType
theFillingStation.numOfChefs
theFillingStation.buildingHeight

//And using the mutating function we can do this:
theFillingStation.theRestaurantType.restaurantSold()



//We can do this kind of nested implementation of classes^ or seperate:
class Planet{
    
    var humansOnPlanet : [Human] = []
    
    init (humans : Human...){
        for human in humans{
            humansOnPlanet.append(human)
        }
    }
    var planetIsDyingIn = 9
    
    func howIsThePlanet (){
        aLoop:for human in humansOnPlanet{
            if human.isDead{
                planetIsDyingIn--
                humansOnPlanet.removeFirst()
                if(planetIsDyingIn <= 1 ){
                    break aLoop
                }
            }
        }
        if(humansOnPlanet.count == 1){
            humansOnPlanet.first!.speak("I thought this would be fun. The planet is dying in \(planetIsDyingIn) year and I'm dying off of loneliness")
        }

    }
}
class Human{
    var isDead = false
    //a class variable
    class var saySomething : String{
        return ("i'm a human")
    }
    enum bloodType : String{
        case O = "Type O"
        case A = "Type A"
        case B = "Type B"
        case AB = "Type AB"
        case ABplus = "Type AB+"
    }

    func speak(toSpeak : String){
        print(toSpeak)
    }

    func kill (anotherHuman : Human){
        anotherHuman.isDead = true
        anotherHuman.speak("I  hope killing me made the world a better place")
    }
}

final class American : Human{
}
final class Italian : Human{
}
final class French : Human{
}
final class Australian : Human{
}
final class Egyptian : Human{
}
final class Nigerian : Human{
}
final class Isreali : Human{
}
final class Palestinian : Human{
}
final class UnknownHuman : Human{
    override static var saySomething : String{
        return ("I'm lonely")
    }
}

var AmericanHuman = American()
var ItalianHuman = Italian()
var FrenchHuman = French()
var AustralianHuman = Australian()
var EgyptianHuman = Egyptian()
var NigerianHuman = Nigerian()
var IsrealiHuman = Isreali()
var PalestinianHuman = Palestinian()
var LastHuman = UnknownHuman()

AmericanHuman.kill(ItalianHuman)
ItalianHuman.isDead
FrenchHuman.kill(AmericanHuman)
AmericanHuman.isDead
AustralianHuman.kill(FrenchHuman)
FrenchHuman.isDead
EgyptianHuman.kill(AustralianHuman)
AustralianHuman.isDead
NigerianHuman.kill(EgyptianHuman)
EgyptianHuman.isDead
IsrealiHuman.kill(NigerianHuman)
NigerianHuman.isDead
PalestinianHuman.kill(IsrealiHuman)
IsrealiHuman.isDead
LastHuman.kill(PalestinianHuman)
PalestinianHuman.isDead


var planetEarth = Planet(humans: AmericanHuman, ItalianHuman, FrenchHuman, AustralianHuman, EgyptianHuman,
NigerianHuman, IsrealiHuman, PalestinianHuman, LastHuman)
planetEarth.howIsThePlanet()



                                                        //Extensions and Protocols
//Extensions
extension Int{
    func isEven() -> Bool{
        if (self % 2 == 0){
            return true
        }
        else{
            return false
        }
    }
}

let someNumber = 1
someNumber.isEven()
let someOtherNumber = 2
someOtherNumber.isEven()

//Protocols
protocol TrackRunner{
    var AverageSpeed100m : Double {get}
    func longJump()
    func lapSpeed()
}
class AfricanRunner: TrackRunner{
    var AverageSpeed100m = 11.2
    func longJump() {
        print("not so good")
    }
    func lapSpeed() {
        print("About 10km/h")
    }
}
class OtherRunner: TrackRunner{
    var AverageSpeed100m = 11.8
    func longJump() {
        print("Really Good")
    }
    func lapSpeed() {
        print("About 9 km/h")
    }
}
struct shortAfricanRunner : TrackRunner{
    var AverageSpeed100m = 13.0
    func longJump() {
        print("surprisingly not bad")
    }
    func lapSpeed() {
        print("About 7 km/h")
    }
}

var runner1 = AfricanRunner ()
var runner2 = OtherRunner ()
var runner3 = shortAfricanRunner ()

runner1.lapSpeed()
runner2.lapSpeed()
runner3.AverageSpeed100m

                                //Collection Types **did some in code before but here's what's left**

var planetEarth2 = [AmericanHuman, ItalianHuman, FrenchHuman, AustralianHuman, EgyptianHuman,
NigerianHuman, IsrealiHuman, PalestinianHuman, LastHuman]

let whosNotDead = planetEarth2.contains { (human) -> Bool in
    return human.isDead == false
}

let indexOfDead = planetEarth2.indexOf { (human) -> Bool in
    return human.isDead == true
}

let newPlanet = planetEarth2.map { (human) -> Human in
    return human
}

planetEarth2.forEach { (human) -> () in
    print(human)
}

for (i, human) in planetEarth2.enumerate()
{
    print("\(i):\(human)")
}

//Dictionaries
var Books = [Int:String]()
Books[5] = "Book1"
Books[15] = "Book2"
Books[74] = "Book3"
Books

let getThisBook = Books[5]
print(getThisBook)


                                                            //Flow Control

//Ternary Expression
var imTired = true
let imAsleep = true
let areYouTired = (imTired == true) ? "Keep going!!!" : "Why are you not tired?"
var time = 3
//While loop
while(imTired){
    switch(time){
    case 1:
        print("that's not that bad..")
    case 2:
        print("meh")
    case 3:
        fallthrough
    case 4:fallthrough
    case 5:fallthrough
    case 6:
        print("THAT'S PRETTY BAD")
        imTired = !imAsleep
    default:
        break
    }
}
//Don't have an idea for a loop to implement continue
//if(you'reTired && you're fatalError()){
//just continue
//}

                                                            //Error Handling
//Creating a throwable
let NetworkError1 : ErrorType = NSError(domain: "com.facebook", code: 0, userInfo: nil)
//throw(NetworkError1)

//Better way to throw is to catch to avoid runtime or compile errors in real time

try? NetworkError1 //Does not cause errors because it works to unwrap if error does not happen
// while try! would in our case cause an error because it would unwrap an error..
do{
    throw(NetworkError1)
}
catch{
    print("Caught a network error")
}

//I apilogize for the late submission, the past weeks have just been a rollercoaster of assignments and tests for me

//3:36 AM DONEEEEEEEE

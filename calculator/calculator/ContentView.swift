//
//  ContentView.swift
//  calculator
//
//  Created by StudentAM on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    //variable to display on top of the buttons
    @State var input : String = "0"
    //where the first number you enter before operation s stored
    @State var firstNum: String = ""
    //where second number after operation is stored
    @State var secNum: String = ""
    //where the operator is stored
    @State var operation: String = ""
    //this array holds an array odf string that contain the infomation put into the buttons
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", "." , "="]
    ]
    var body: some View{
    // the z stack with the black at the top makes the hwole screen balck
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                //this will display whatever is inside the input
                Text("\(input)")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                // if more than 6 numbers are in the input the font will become smaller to make more room on the screen in the input
                    .font( input.count >= 6 ? .system(size:55): .system(size:90))
                    .padding()
                    
                // the for each loop allows the contents inside the array or array od strings info to be put into certain buttons and for them to be styled
                ForEach(numsAndOperations, id:\.self){row in
                    HStack{
                        ForEach(row, id:\.self){circle in
                            if circle == "AC" || circle == "+/-" || circle == "%"{
                                Button("\(circle)", action:{
                                    handelClick(buttonClicked: circle)
                                })
                                .frame(width:80, height:80)
                                .background(Color(UIColor.lightGray))
                                .cornerRadius(50)
                                .foregroundStyle(Color.white)
                                .font(.title)
                                        
                            }
                            else if circle == "÷" || circle == "x" || circle == "-" || circle == "+" || circle == "="{
                                Button("\(circle)", action:{
                                    handelClick(buttonClicked: circle)
                                })
                                .frame(width:80, height:80)
                                .background(Color.orange)
                                .cornerRadius(50)
                                .foregroundStyle(Color.white)
                                .font(.largeTitle)
                            }
                            else if circle == "0"{
                                Button("\(circle)", action:{
                                    handelClick(buttonClicked:  circle)
                                })
                                .frame(width:165, height:80)
                                .background(Color(UIColor.darkGray))
                                .cornerRadius(50)
                                .foregroundStyle(Color.white)
                                .font(.largeTitle)
                            }
                            else {
                                Button("\(circle)", action:{
                                    handelClick(buttonClicked: circle)
                                })
                                .frame(width:80, height:80)
                                .background(Color(UIColor.darkGray))
                                .cornerRadius(50)
                                .foregroundStyle(Color.white)
                                .font(.largeTitle)
                            }
                        }
                    }
                
                }
            }
    
        }
        
    }
    // this function is what is going to help know what button is clicked and what to display on the input
    func handelClick(buttonClicked: String){
        if buttonClicked == "AC"{
            input = "0"
//            buttonClicked = "C"
                    }
        else if buttonClicked == "+/-"{
            if let numInput = Int(input){
                input = "\(numInput * -1)"
            }
        }
        else if buttonClicked == "."{
            input += "."
        }
        else if buttonClicked == "x" || buttonClicked == "÷" || buttonClicked == "-" || buttonClicked == "+" {
            firstNum = input
            input = "0"
            //stored the operator in the operation
            operation = buttonClicked
        }
        else if buttonClicked == "="{
            secNum = input
            //after the equal is hit the function is run that does the math problems with all the numbers and operations stored
            doMath()
        }
        // calculates percentage
        else if buttonClicked == "%"{
            if let numOne = Double(input){
                input = String(numOne * 0.01)
            }
        }
        // this will allow you to add 2 numbers in the input at a time not jsut adding them together
        else{
            if input == "0"{
                input = buttonClicked
            }
            else{
                input += buttonClicked
            }
                
            
        }
        
    }
    // this function will do the math problems with the numbers and operation stored
    func doMath(){
        // convertes the num string inot doubles if the nums contin a . so that the math can be done
        if firstNum.contains(".") || secNum.contains(""){
            if let numOne = Double(firstNum), let numTwo = Double(secNum){
                // depending on the operation determines math done
                //then input is equal to the answer
                if operation == "+"{
                    input = String(numOne + numTwo)
                }
                else if operation == "-"{
                    input = String(numOne - numTwo)
                }
                else if operation == "x"{
                    input = String(numOne * numTwo)
                }
                else {
                    input = String(numOne/numTwo)
                }
            }
        }
        // if its a regular number without a . then make them integers to do the math
        // roughly same notes as the double ne above 
        else{
            if let numOne = Int(firstNum), let numTwo = Int(secNum){
                if operation == "+"{
                    input = String(numOne + numTwo)
                }
                else if operation == "-"{
                    input = String(numOne - numTwo)
                }
                else if operation == "x"{
                    input = String(numOne * numTwo)
                }
                else {
                    input = String(numOne/numTwo)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

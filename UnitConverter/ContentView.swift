//
//  ContentView.swift
//  UnitConverter
//
//  Created by Ivan Kodrnja on 08.11.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var numberToConvert = 0.0
    @State private var inputUnit = "milimeter"
    @State private var outputUnit = "inches"
    @FocusState private var amountIsFocused: Bool
    
    let inputUnits = ["milimeter", "centimeter", "meter", "kilometer"]
    let outputUnits = ["inches", "feet", "yards", "miles"]
    
    var chosenInputUnit: Double {
        var result = 1.0
        
        switch inputUnit {
            case "centimeter":
                result = 10.0
            case "meter":
                result = 1000.0
            case "kilometer":
                result = 1000000.0
            default:
                result = 1.0
        }
        
        return result
    }
    
    var chosenOutputUnit: Double {
        var result = 1.0
        
        switch outputUnit {
            case "feet":
                result = 1 / 12.0
            case "yards":
                result = 1 / 36.0
            case "miles":
                result = 1 / 63360.0
            default:
                result = 1.0
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Number to convert", value: $numberToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Enter a number")
                }
                
                Section {
                    Picker("Select input unit", selection: $inputUnit){
                        ForEach(inputUnits, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input unit")
                }
                
                Section {
                    Picker("Select output unit", selection: $outputUnit){
                        ForEach(outputUnits, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output unit")
                }
                
                Section {
                    Text((numberToConvert * chosenInputUnit * chosenOutputUnit * 0.0393701).formatted())
                } header: {
                    Text("The result")
                }
                
            }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Unit Converter")
                        .toolbar{
                            ToolbarItemGroup(placement: .keyboard){
                                Spacer()
                                Button("Done"){
                                    amountIsFocused = false
                                }
                            }
                        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

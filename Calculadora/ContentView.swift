//
//  ContentView.swift
//  Calculadora
//
//  Created by MAC on 18/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var texto1 = ""
    @State private var texto2 = ""
    @State private var result = "0"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Operaciones")
                .font(.largeTitle)
                .bold()
            TextField("Primer numero", text: $texto1)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            TextField("Segundo numero", text: $texto2)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            HStack(spacing: 12) {
                BotonOperacion(simbolo: "plus") { calcular("+") }
                BotonOperacion(simbolo: "minus") { calcular("-") }
                BotonOperacion(simbolo: "multiply") { calcular("*") }
                BotonOperacion(simbolo: "divide") { calcular("/") }
            }
            
            Text("Resultado")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text(result)
                .font(.system(size: 48, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Spacer()
        }
        .tint(.orange)
        .padding()
    }
    
    func calcular(_ operacion: String) {
        guard let a = Double(texto1), let b = Double(texto2) else {
            result = "Escribe dos numeros"
            return
        }
        
        switch operacion {
        case "+": result = formatear(a + b)
        case "-": result = formatear(a - b)
        case "*": result = formatear(a * b)
        case "/":
            if b == 0 {
                result = "No se puede dividir entre 0"
            } else {
                result = formatear(a / b)
            }
        default: break
        }
    }
    
    func formatear(_ x: Double) -> String {
        if x == x.rounded() && abs(x) < 1e15 {
            return String(Int(x))
        }
        return String(x)
    }
}

struct BotonOperacion: View {
    let simbolo: String
    let accion: () -> Void
    
    var body: some View {
        Button(action: accion) {
            Image(systemName: simbolo)
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 44)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ContentView()
}

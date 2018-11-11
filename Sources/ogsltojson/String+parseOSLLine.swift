//
//  String+parseOSLLine.swift
//  ogsltojson
//
//  Created by Chaitanya Kanchan on 11/11/2018.
//

extension String {
    func parseOSLLine() -> (OSL.CommandLine)? {
        var components = self.split(separator: Character(" "))
        guard components.count > 0 else {return nil}
        let commandLiteral = components.removeFirst()
        guard let command = OSL.Command.init(rawValue: String(commandLiteral)) else { return nil}
        return (command, components.map{String($0)})
    }
}

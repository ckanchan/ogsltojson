//
//  String+parseOSLLine.swift
//  ogsltojson: converts Oracc SL files to JSON
//  Copyright (C) 2018 Chaitanya Kanchan
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.

extension String {
    func parseOSLLine() -> (OSL.CommandLine)? {
        var components = self.split(separator: Character(" "))
        guard components.count > 0 else {return nil}
        let commandLiteral = components.removeFirst()
        guard let command = OSL.Command.init(rawValue: String(commandLiteral)) else { return nil}
        return (command, components.map{String($0)})
    }
}

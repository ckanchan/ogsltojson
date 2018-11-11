import Foundation

let usageString = """
ogsltojson
Converts an Oracc Global Sign List file to JSON

USAGE
ogsltojson [OGSLSTRING]
ogsltojson --input [OGSLPATH] [OUTPUTPATH]?

If OUTPUTPATH is not supplied, print JSON to stdout

"""

func main() -> Bool {
    switch CommandLine.arguments.count {
    case 2:
        do {
            try decode(ogslPath: nil, toFile: nil)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    case 3: // print to stdout
        do {
            try decode(ogslPath: CommandLine.arguments[1], toFile: nil)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
        
    case 4: // save to file
        do {
            try decode(ogslPath: CommandLine.arguments[1], toFile: CommandLine.arguments[2])
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
        
    default:
        print(usageString)
        return false
    }
}

func decode(ogslPath: String?, toFile filePath: String?) throws {
    let ogslString: String
    
    if let ogslPath = ogslPath {
        let dataURL = URL(fileURLWithPath: ogslPath)
        ogslString = try String(contentsOf: dataURL)
    } else {
        ogslString = CommandLine.arguments[1]
    }
    
    let signs = OSL.makeSignList(ogslString)
    
    // If there are no signs, useless to carry on so throw error
    if signs.isEmpty {
        throw OGSLError.NoSignsDecoded
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let data = try encoder.encode(signs)
    if let targetPath = filePath {
        let url = URL(fileURLWithPath: targetPath)
        try data.write(to: url)
    } else {
        let json = String(data: data, encoding: .utf8)! // This shouldn't fail
        print(json)
    }
    
}

if main() {
    exit(EXIT_SUCCESS)
} else {
    exit(EXIT_FAILURE)
}

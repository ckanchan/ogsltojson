import XCTest
import class Foundation.Bundle


final class ogsltojsonTests: XCTestCase {
    func testDecodingCuneiformSignA() throws {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }
        
        let binary = productsDirectory.appendingPathComponent("ogsltojson")
        let process = Process()
        process.executableURL = binary
        process.arguments = [OGSLTestData.cuneiformSignA]
        
        let pipe = Pipe()
        process.standardOutput = pipe
        
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8)  {            
            XCTAssertEqual(output, OGSLTestData.jsonSignA)
        } else {
            XCTFail()
        }
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
    
    static var allTests = [
        ("testDecodingCuneiformSignA", testDecodingCuneiformSignA),
    ]
}

enum OGSLTestData {}
extension OGSLTestData {
    static let cuneiformSignA = """
    @sign    A
    @list    LAK797
    @list    MZL839
    @uphase    1
    @uname    CUNEIFORM SIGN A
    @ucode    x12000    𒀀
    @v    ʾu₄
    @v    a
    @v    aia₂
    @v    aya₂
    @v    barₓ
    @v    buniŋₓ
    @v    burₓ
    @v    dur₅
    @v    duru₅
    @v    e₄
    @v    ea
    @v    ebir₃
    @v    emₓ
    @v    epir₃
    @v    eš₁₀
    @v    ŋa₁₀
    @v    ia₁₀
    @v?    id₅
    @v    me₅
    @v    mu₁₄
    @v    sedₓ
    @v    šegₓ
    @v    ṭur₅
    @v    ya₁₀
    @end sign
    """
    
    static let jsonSignA = """
[
  {
    "unicodeName" : "CUNEIFORM SIGN A",
    "sign" : "A",
    "values" : [
      "a",
      "aia₂",
      "aya₂",
      "barₓ",
      "buniŋₓ",
      "burₓ",
      "duru₅",
      "dur₅",
      "ea",
      "ebir₃",
      "emₓ",
      "epir₃",
      "eš₁₀",
      "e₄",
      "ia₁₀",
      "me₅",
      "mu₁₄",
      "sedₓ",
      "ya₁₀",
      "ŋa₁₀",
      "šegₓ",
      "ʾu₄",
      "ṭur₅"
    ],
    "characterCode" : "x12000",
    "utf8" : "𒀀"
  }
]

"""
}

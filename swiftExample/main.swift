//
//  main.swift
//  swiftExample
//
//  Created by Wong Cheuk Yin on 27/10/2020.
//

import Foundation

print("Hello, World!")

class Track {
    let name: String
    let instructor: String
    
    init(name: String, instructor: String) {
        self.name = name
        self.instructor = instructor
    }
}

let tracks = [
    Track(name: "Web", instructor: "Kelvin"),
    Track(name: "Mobile", instructor: "Stanley"),
    Track(name: "Game", instructor: "Clint")
]

let students = ["Harry", "Scott", "Garvin"]

var assignment: [String : Track] = [:]

for student in students {
    let track = Int.random(in: 0 ..< tracks.count)
    assignment[student] = tracks[track]
}

for (student, track) in assignment {
    print("\(student) got \(track.name) with \(track.instructor)")
}



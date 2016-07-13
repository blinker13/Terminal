
import PackageDescription

let package = Package(
    name: "say",

    dependencies:[
        .Package(url: "https://github.com/blinker13/Terminal.git", majorVersion:1),
    ]
)

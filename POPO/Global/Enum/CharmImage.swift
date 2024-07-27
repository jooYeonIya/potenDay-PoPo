//
//  CharmImage.swift
//  POPO
//
//  Created by 강주연 on 7/26/24.
//

import Foundation

struct Coordinates {
    let x: Int
    let y: Int
}

struct ImageCoordinates {
    let coord1: Coordinates
    let coord2: Coordinates
}

enum Images: Int {
    case image0
    case image1
    case image2
    case image3
    case image4
    case image5
    case image6
    
    var name: String {
        switch self {
        case .image0: return "CharmVer0"
        case .image1: return "CharmVer1"
        case .image2: return "CharmVer2"
        case .image3: return "CharmVer3"
        case .image4: return "CharmVer4"
        case .image5: return "CharmVer5"
        case .image6: return "CharmVer6"
        }
    }
    
    var coordinates: ImageCoordinates {
        switch self {
        case .image0:
            return ImageCoordinates(coord1: Coordinates(x: 203, y: 339),
                                    coord2: Coordinates(x: 180, y: 1134))
        case .image1:
            return ImageCoordinates(coord1: Coordinates(x: 203, y: 354),
                                    coord2: Coordinates(x: 187, y: 1180))
        case .image2:
            return ImageCoordinates(coord1: Coordinates(x: 200, y: 458),
                                    coord2: Coordinates(x: 170, y: 928))
        case .image3:
            return ImageCoordinates(coord1: Coordinates(x: 213, y: 297),
                                    coord2: Coordinates(x: 186, y: 681))
        case .image4:
            return ImageCoordinates(coord1: Coordinates(x: 116, y: 525),
                                    coord2: Coordinates(x: 120, y: 912))
        case .image5:
            return ImageCoordinates(coord1: Coordinates(x: 256, y: 381),
                                    coord2: Coordinates(x: 152, y: 798))
        case .image6:
            return ImageCoordinates(coord1: Coordinates(x: 124, y: 350),
                                    coord2: Coordinates(x: 147, y: 818))
        }
    }
}

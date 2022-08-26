//
//  Rocket.swift
//  SpaceX-Rockets
//
//  Created by Pavel on 26.08.22.
//

import Foundation

struct Rocket: Codable {
    let height, diameter: Length
    let mass: Weight
    let firstStage: Stage?
    let secondStage: Stage?
    let payloadWeights: [Weight]
    let images: [String]
    let name: String
    let costPerLaunch: Int
    let firstFlight, country, company: String
    let id: String

    var costInMillions: Double {
        round((Double(costPerLaunch) / 1_000_000.00) * 100) / 100.0
    }
    
    var totalPayloadLb: Int {
        payloadWeights.reduce(0) { x, y in x + y.lb }
    }
    
    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case images = "flickr_images"
        case name
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country, company
        case id
    }
}

// MARK: - Stage
struct Stage: Codable {
    let engines: Int
    let burnTimeSEC: Int?
    let fuelAmountTons: Double
    
    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - Length
struct Length: Codable {
    let meters, feet: Double
}

// MARK: - Weight
struct Weight: Codable {
    let kg, lb: Int
}

extension Rocket {
    static func example() -> Rocket {
        let jsonData = """
        {
        "height": {
            "meters": 70,
            "feet": 229.6
        },
        "diameter": {
            "meters": 12.2,
            "feet": 39.9
        },
        "mass": {
            "kg": 1420788,
            "lb": 3125735
        },
        "first_stage": {
            "thrust_sea_level": {
                "kN": 22819,
                "lbf": 5130000
            },
            "thrust_vacuum": {
                "kN": 24681,
                "lbf": 5548500
            },
            "reusable": true,
            "engines": 27,
            "fuel_amount_tons": 1155,
            "burn_time_sec": 162
        },
        "second_stage": {
            "thrust": {
                "kN": 934,
                "lbf": 210000
            },
            "payloads": {
                "composite_fairing": {
                    "height": {
                        "meters": 13.1,
                        "feet": 43
                    },
                    "diameter": {
                        "meters": 5.2,
                        "feet": 17.1
                    }
                },
                "option_1": "dragon"
            },
            "reusable": false,
            "engines": 1,
            "fuel_amount_tons": 90,
            "burn_time_sec": 397
        },
        "engines": {
            "isp": {
                "sea_level": 288,
                "vacuum": 312
            },
            "thrust_sea_level": {
                "kN": 845,
                "lbf": 190000
            },
            "thrust_vacuum": {
                "kN": 914,
                "lbf": 205500
            },
            "number": 27,
            "type": "merlin",
            "version": "1D+",
            "layout": "octaweb",
            "engine_loss_max": 6,
            "propellant_1": "liquid oxygen",
            "propellant_2": "RP-1 kerosene",
            "thrust_to_weight": 180.1
        },
        "landing_legs": {
            "number": 12,
            "material": "carbon fiber"
        },
        "payload_weights": [
            {
                "id": "leo",
                "name": "Low Earth Orbit",
                "kg": 63800,
                "lb": 140660
            },
            {
                "id": "gto",
                "name": "Geosynchronous Transfer Orbit",
                "kg": 26700,
                "lb": 58860
            },
            {
                "id": "mars",
                "name": "Mars Orbit",
                "kg": 16800,
                "lb": 37040
            },
            {
                "id": "pluto",
                "name": "Pluto Orbit",
                "kg": 3500,
                "lb": 7720
            }
        ],
        "flickr_images": [
            "https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg",
            "https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg",
            "https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg",
            "https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg"
        ],
        "name": "Falcon Heavy",
        "type": "rocket",
        "active": true,
        "stages": 2,
        "boosters": 2,
        "cost_per_launch": 90000000,
        "success_rate_pct": 100,
        "first_flight": "2018-02-06",
        "country": "United States",
        "company": "SpaceX",
        "wikipedia": "https://en.wikipedia.org/wiki/Falcon_Heavy",
        "description": "With the ability to lift into orbit over 54 metric tons (119,000 lb)--a mass equivalent to a 737 jetliner loaded with passengers, crew, luggage and fuel--Falcon Heavy can lift more than twice the payload of the next closest operational vehicle, the Delta IV Heavy, at one-third the cost.",
        "id": "5e9d0d95eda69974db09d1ed"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let rocket = try? decoder.decode(Rocket.self, from: jsonData)
        return rocket!
    }
}

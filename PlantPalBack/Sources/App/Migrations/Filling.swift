//
//  File.swift
//  
//
//  Created by Михаил Прозорский on 10.07.2024.
//

import Fluent

struct Filling: AsyncMigration {
    let dict = ["1": "pink primrose", "2": "hard-leaved pocket orchid", "3": "canterbury bells", "4": "sweet pea", "5": "english marigold", "6": "tiger lily", "7": "moon orchid", "8": "bird of paradise", "9": "monkshood", "10": "globe thistle", "11": "snapdragon", "12": "colt's foot", "13": "king protea", "14": "spear thistle", "15": "yellow iris", "16": "globe-flower", "17": "purple coneflower", "18": "peruvian lily", "19": "balloon flower", "20": "giant white arum lily", "21": "fire lily", "22": "pincushion flower", "23": "fritillary", "24": "red ginger", "25": "grape hyacinth", "26": "corn poppy", "27": "celosia", "28": "stemless gentian", "29": "artichoke", "30": "sweet william", "31": "carnation", "32": "garden phlox", "33": "love in the mist", "34": "cosmos", "35": "alpine sea holly", "36": "ruby-lipped cattleya", "37": "nerine", "38": "great masterwort", "39": "siam tulip", "40": "lenten rose", "41": "barbeton daisy", "42": "daffodil", "43": "gladiolus", "44": "poinsettia", "45": "bolero deep blue", "46": "wallflower", "47": "marigold", "48": "buttercup", "49": "oxeye daisy", "50": "common dandelion", "51": "petunia", "52": "wild pansy", "53": "primula", "54": "sunflower", "55": "pelargonium", "56": "bishop of llandaff dahlia", "57": "gaura", "58": "geranium", "59": "tithonia", "60": "pink-yellow dahlia", "61": "cautleya spicata", "62": "japanese anemone", "63": "black-eyed susan", "64": "silverbush", "65": "californian poppy", "66": "osteospermum", "67": "spring crocus", "68": "bearded iris", "69": "windflower", "70": "tree poppy", "71": "gazania", "72": "azalea", "73": "water lily", "74": "rose", "75": " thorn apple", "76": "morning glory", "77": "passion flower", "78": "lotus", "79": "toad lily", "80": "anthurium", "81": "frangipani", "82": "clematis", "83": "hibiscus", "84": "columbine", "85": "desert-rose", "86": "tree mallow", "87": "magnolia", "88": "cyclamen", "89": "watercress", "90": "canna lily", "91": "hippeastrum", "92": "bee balm", "93": "ball moss", "94": "foxglove", "95": "bougainvillea", "96": "camellia", "97": "mallow", "98": "mexican petunia", "99": "bromelia", "100": "blanket flower", "101": "trumpet creeper", "102": "blackberry lily"]
    
    func prepare(on database: FluentKit.Database) async throws {
        for key in dict.keys {
            let plant = Plant(name: dict[key]!, description: "Красивое растение", imageURL: "https://cdn-icons-png.flaticon.com/512/4814/4814772.png", temp: "20 - 38 ºC", humidity: "75–78%", waterInterval: 1, seconds: 5, MLID: key)
            try await plant.save(on: database)
        }
    }
    
    func revert(on database: FluentKit.Database) async throws {
        try await database.schema("plants").delete()
    }
}

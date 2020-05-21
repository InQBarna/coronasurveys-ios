//
//  URL`.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 21/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

extension URL {
    func queryValue(for key: String) -> String? {
        let request = URLComponents(url: self, resolvingAgainstBaseURL: false)

        let queryItem = request?.queryItems?.first(where: { (queryItem) -> Bool in
            queryItem.name == key
        })

        return queryItem?.value
    }
}

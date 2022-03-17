//
//  DateFormatter+Extensionswift.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import Foundation

extension  DateFormatter {
    static let shortLocalStyle: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    static let longLocalStyle: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        return dateFormatter
    }()
}

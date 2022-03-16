//
//  DateFormatter+Extensionswift.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import Foundation

extension  DateFormatter {
    static let shortLocalStyle: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale.current
        df.dateStyle = .short
        df.timeStyle = .none
        df.dateFormat = "dd.MM.yyyy"
        return df
    }()  
}

//
//  Extenstions.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 12.01.2023.
//



extension String {
    
    func capitilizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

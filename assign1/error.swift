//
//  error.swift
//  assign1
//
//  Created by 杜思娴 on 2025/1/10.
//

enum MyError: Error, Equatable{
    case invalidInput(String)
    case duplicatedMedication
    case missingBloodType
}

//
//  User.swift
//  iOSLabAdvancedConcurrency
//
//  Created by Ляйсан
//

import Foundation

struct User: Identifiable, Codable, Sendable, Equatable {
    let id: String
    let firstName: String
    let username: String
    let email: String
    let phone: String
    let age: Int
    let country: String
    let job: String
    let company: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case phone
        case firstName = "first_name"
        case age
        case country
        case job
        case company
    }
}

extension User {
    static var mockUsers: [User] {
        [
            User(
                id: "1",
                firstName: "Иван",
                username: "ivan_petrov",
                email: "ivan@example.com",
                phone: "+7 (999) 123-45-67",
                age: 28,
                country: "Россия",
                job: "iOS Developer",
                company: "TechCorp"
            ),
            User(
                id: "2",
                firstName: "Мария",
                username: "maria_s",
                email: "maria@example.com",
                phone: "+7 (999) 234-56-78",
                age: 25,
                country: "Россия",
                job: "UI/UX Designer",
                company: "DesignStudio"
            ),
            User(
                id: "3",
                firstName: "Алексей",
                username: "alex_ivanov",
                email: "alex@example.com",
                phone: "+7 (999) 345-67-89",
                age: 32,
                country: "Россия",
                job: "Backend Developer",
                company: "WebSolutions"
            ),
            User(
                id: "4",
                firstName: "Елена",
                username: "elena_k",
                email: "elena@example.com",
                phone: "+7 (999) 456-78-90",
                age: 27,
                country: "Россия",
                job: "Project Manager",
                company: "InnovateInc"
            ),
            User(
                id: "5",
                firstName: "Дмитрий",
                username: "dmitry_s",
                email: "dmitry@example.com",
                phone: "+7 (999) 567-89-01",
                age: 35,
                country: "Россия",
                job: "QA Engineer",
                company: "QualitySoft"
            )
        ]
    }
}

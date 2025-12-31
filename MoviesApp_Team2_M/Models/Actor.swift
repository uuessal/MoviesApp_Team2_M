//
//  Actor.swift
//  MoviesApp_Team2_M
//
//  Created by Lojaen Jehad Ayash
//

import Foundation

struct ActorFields: Decodable {
    let name: String
    let image: String
}

struct Actor: Decodable, Identifiable {
    let id: String
    let fields: ActorFields
}

struct ActorsResponse: Decodable {
    let records: [Actor]
}

struct MovieActorFields: Decodable {
    let movie_id: String
    let actor_id: String
}

struct MovieActor: Decodable {
    let id: String
    let fields: MovieActorFields
}

struct MovieActorsResponse: Decodable {
    let records: [MovieActor]
}

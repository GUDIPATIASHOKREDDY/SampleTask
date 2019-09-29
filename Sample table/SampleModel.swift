

import Foundation


struct SharedData {
    static var data = SharedData()
   
}


struct Responsedata :Codable
{
    let events:[Events]?
    
}

struct Events :Codable
{
    let performers:[Performers]?
     let title:String?
    let venue:Venue?
    let created_at:String?
    
}
struct Venue :Codable
{
    let display_location:String?
}
struct Performers :Codable
{
    let image:String?
    
}
struct Results :Codable
{
    let artistName:String?
    let releaseDate:String?
    let name:String?
    let kind:String?
    let artworkUrl100:String?
    let copyright:String?
    let genres:[Genres]
    let url:String?
    let artistUrl:String?
    
    
}

struct Genres :Codable
{
   let genreId:String?
    let name:String?
let url:String?

}


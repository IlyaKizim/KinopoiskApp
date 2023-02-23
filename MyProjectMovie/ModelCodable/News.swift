//
//  News.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 21.02.2023.
//

import Foundation

struct TitleNews: Codable {
    let articles: [News]
}
struct News: Codable {
    let author: String?
    let content: String?
    let description: String?
    let publishedAt: String?
    let title: String?
    let url: String?
    let urlToImage: String?
}

/*
{
    articles =     (
                {
            author = Wired;
            content = "In 2017,\U00a0Hulu made television history by becoming the first streaming network to win the Outstanding Drama Series Emmy, thanks to the phenomenon that is\U00a0The Handmaids Tale. While that painfully presc\U2026 [+5536 chars]";
            description = "From 'Fresh' to 'Heat', these are all the films you need to be watching on the streaming service right now.";
            publishedAt = "2023-02-15T20:00:00Z";
            source =             {
                id = wired;
                name = Wired;
            };
            title = "8 Best Movies on Hulu This Week";
            url = "https://www.wired.com/story/best-movies-hulu-right-now/";
            urlToImage = "https://media.wired.com/photos/63ed2f02dcab861f7a4746ed/191:100/w_1280,c_limit/8-Best-Movies-on-Hulu-This-Week-Fresh-Culture.jpg";
        },
                {
            author = "Angela Watercutter";
            content = "Do you guys love science fiction?
\nStahelski: Im always big on sci-fi. Like, John Wick is hyperreal. But its also got this analog sense. Old computers, old suits, old stuff.
\nReeves: Im interested in\U2026 [+2543 chars]";
            description = "The Matrix movies brought Reeves and Chad Stahelski together. Now the duo is killing it on their fourth John Wick\U2014and still keeping technology in check.";
            publishedAt = "2023-02-14T11:00:00Z";
            source =             {
                id = wired;
                name = Wired;
            };
            title = "Keanu Reeves Will Never Surrender to the Machines";
            url = "https://www.wired.com/story/keanu-reeves-chad-stahelski-interview/";
            urlToImage = "https://media.wired.com/photos/63dac81484464089ca2fc691/191:100/w_1280,c_limit/WI030123_FF_HitMen_01.jpg";
        }
*/

<p align="center">
    <h1> ⚡️SonghoundFilterEngine ⚡️ </h1>
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="https://discord.gg/vapor">
        <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>


## About

 This server communicates with firebase and aggregates artists data and top songs to one JSON body
 will also be the homepage for my app

## Search API

The Search API allows you to search for favourite music in your area.

issue a get request to  /fire with the params songName="" and location="". 
where location is the suburb name 

### Example
we will use apples infinite loop location.
`curl -XGET https://sh100xdivinedube33.vapor.cloud/fire?songName='Blank '&location='Cupertino'`

### Response

`
{
    "907104698": { 
                    "name":"Blank Space",
                    "songID":907104698
                 }
 }
`

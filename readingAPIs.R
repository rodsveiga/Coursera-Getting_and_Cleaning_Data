library(httr)

## Accessing Twitter from R.

## Start the authorization process.
myapp = oauth_app("twitter",key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
## The "yourConsumerKeyHere" and "yourConsumerSecretHere" are taken
## from the apllication website.
sig = sign_oauth1.0(myapp, token="yourTokenHere",token_secret="yourTokenSecretHere")
## The "yourTokenHere" and "yourTokenSecretHere" are also take from the website.

## We have actually sort of created the credentials that will allow us to acess
## data that is privately held by Twitter that is only available to people
## with an apllication.

## GET command. Very specific URL. The one that corresponds to the twitter API.
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
## 1.1 is the API version we are using
## Some more components which correspond to which data we'd loke to get out.
## statuses/home_timeline: statused on the home timeline, got in a JSON file.
## The homeTL object is actually some json data.

## Converting the json object.
library(jsonlite)

## Extracting the json data.
json1 = content(homeTL)
## This content function will recognize and create the JSON data. 
## It is going to use the fromJSOBN function from the R JSON IO package, so
## that will retunt sort of a structured R obejct. Hard to read.

## Using the JSONLITE package to reformat the data as a data frame.
json2 = jsonlite::fromJSON(toJSON(json1))
## From JSON, to JSON, using JSONLITE.

## Each row corresponf to a tweet in the home timeline.
json2[1,1:4]

## In general look at the documentation:

## httr allows GET, POST, PUT, DELETE requests if you are authorized.
## You ca authenticate with a user name or password.
## Most modern APIs use something like oauth.
## httr works well with Facebook, Google, Twitter, Github, etc.

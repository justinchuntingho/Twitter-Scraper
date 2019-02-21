## Getting Twitter API Key
# To access the Twitter APIs, you will need to register a twitter application. To register a twitter application and get your consumer keys:
#   1. Follow the instuction below to register for a developer account: 
#     https://www.extly.com/docs/autotweetng_joocial/tutorials/how-to-auto-post-from-joomla-to-twitter/apply-for-a-twitter-developer-account/#apply-for-a-developer-account
#   2. Go to [Twitter's App Page](https://apps.twitter.com) in a web browser.
#             1. Click on 'create new app'.
#             2. Give your app a unique name, a description, any relevant web address, and agree to the terms and conditions. Set the callback URL to http://127.0.0.1:1410. You might have to add a cellphone number your twitter account.
#             3. Go to the keys and access section of the app page, and copy your consumer key and consumer secret to the code below.
#             4. (optional): For actions requiring write permissions, generate an access token and access secret.
#             (Drafted by Ken Benoit)

# You will also need to install at least the following R packages:
# Remember you only have to run them ONCE
install.packages(c('twitteR', 'RCurl', 'ROAuth', 'httr'))

# Here you copy and paste your keys and secret
consumerKey <- 'Cpkhh548SzfunqlxzDOFaphu7'
consumerSecret <- '5QOBpf9uhWUhik1eoNgRVAb3hwFvA27R0QcqosohD88k3535GP'
accessToken <- '1089196481465208833-kZHPciSGS5QT5zvx7sDgVI750CBw4Z'
accessSecret <- '21xS9RD4chWgsSOK9zhpdDMUH1D9EFiDLmF75ZtYH1BhW'

# After you run this thing, you might have to type "1" in the console
require(twitteR)
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessSecret)

# Capture the tweets
results <- searchTwitter(searchString="trump", n=500) # Change the search word and number of tweets to capture

# Preview the tweets
twdf <- as.data.frame(t(sapply(results, as.data.frame)))
head(twdf$text)

# Write to a csv file
csvdf <- data.frame(unlist(twdf$text), unlist(twdf$favorited), unlist(twdf$favoriteCount), unlist(twdf$replyToSN), unlist(twdf$created), unlist(twdf$truncated), unlist(twdf$replyToSID), unlist(twdf$id), unlist(twdf$replyToUID), unlist(twdf$statusSource), unlist(twdf$screenName), unlist(twdf$retweetCount), unlist(twdf$isRetweet), unlist(twdf$retweeted), unlist(twdf$longitude), unlist(twdf$latitude))
colnames(csvdf) <- names(twdf)
write.csv(csvdf, "tweets.csv", row.names=FALSE) # you might change the file name
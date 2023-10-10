# client.id<-'WkpUUHY4RTUwY1BTV0MzdXJUVk06MTpjaQ'
# client.secret<-'cMUiKdTwcFqC5wzd05w-0oJDykEB_Xt7lUWLKPmZkhUi6zFuE4'
# api.key<-'AfCleIRrcDoqBYkaJAKCbw9aj'
# api.key.secret<-'yWGj0mqkuFxi89zcW98CQsQTZwTq3w91pklGk5UljLqxcihoWC'
# access.token<-'1711458072357470208-JjSHclZY5zIi1HcHEQHOweofR3pjQ9'
# access.token.secret<-'ybyyFWl0SN6r8xXk0Tgx8aGok852d7xHTOfNI77ZCCISX'


library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)


#Connect to Twitter
setup_twitter_oauth(api.key,api.key.secret,access.token,access.token.secret)

#Returning Tweets
soccer.tweets<-searchTwitter('soccer',n=1000,lang='en')


#Grabbing text data from Tweets
soccer.text<-sapply(soccer.tweets,function(x) x$getText())

#Clean text data
soccer.text<-iconv(soccer.text,'UTF-8','ASCII')

soccer.corpus<-Corpus(VectorSource(soccer.text))


#Document Term Matrix
term.doc.matrix<-TermDocumentMatrix(soccer.corpus,
                                    control=list(removePunctuation=T,
                                                 stopwords=c('soccer',stopwords('english')),
                                                 removeNumbers=T,
                                                 tolower=T))
#Convert object into matrix
term.doc.matrix<-as.matrix(term.doc.matrix)

#Get World Counts
word.freq<-sort(rowSums(term.doc.matrix),decreasing = T)
dm<-data.frame(word=names(word.freq),freq=word.freq)


#Create the WordCloud
wordcloud(dm$word,dm$freq,random.order = F,colors = brewer.pal(8,'Dark2'))

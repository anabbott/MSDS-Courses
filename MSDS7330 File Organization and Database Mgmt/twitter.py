import pymongo
import tweepy
import json
import time
from tweepy import OAuthHandler
from tweepy import Stream
from tweepy.streaming import StreamListener

consumer_key = '5bfLSp4ua7zAalFtKw08ujMna'
consumer_secret = 'P5EDPo1z4BwMbD4BuCIcwP4mWY9hxC1mfL2Bp0Vyd5qMYerhDu'
access_token = '6606412-UYqud5g3qq50i4iqFkBm9YIktpMgmrYGNPLBPsJspu'
access_secret = 'FjzLrfehZhfsTeeQl4vmck39ysYzLTq2KZzcPbSIDJddv'

auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_secret)

api = tweepy.API(auth)

class MyListener(StreamListener):
    
    def __init__(self, time_limit=60):
        self.start_time = time.time()
        self.limit = time_limit
    
    def on_data(self, data):
        if (time.time() - self.start_time) < self.limit:
            conn = pymongo.MongoClient()
            db = conn.twitter
            tweet = json.loads(data)
            db.tweets.insert_one(tweet)
            return True
        else:
            return False
            
    
twitter_stream = Stream(auth, MyListener())
twitter_stream.filter(track=['#Rockets'])


tweets = db.tweets.find()
for tweet in tweets:
    print(tweet['user']['name'] + ',', tweet['text'])
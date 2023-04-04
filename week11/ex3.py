from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def delete_single_Brooklyn():
    db.laba.delete_one({'borough': 'Brooklyn'})


def delete_all_Thai():
    db.laba.delete_many({'cuisine': 'Thai'})


delete_single_Brooklyn()
delete_all_Thai()

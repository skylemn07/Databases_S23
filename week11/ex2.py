import datetime

from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def insert_specific_restaraunt():
    restaraunts.insert_one(
        {
            'address': {'building': '126', 'coord': [-73.9557413, 40.7720266], 'street': 'Sportivnaya', 'zipcode': '420500'},
            'borough': ' Innopolis', 'cuisine': 'Serbian',
            'grades': [{'date': datetime.datetime(2023, 4, 4, 0, 0), 'grade': 'A', 'score': 11}],
            'name': 'The Best Restaurant',
            'restaurant_id': '41712354'
        })


insert_specific_restaraunt()

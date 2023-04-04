from pymongo import MongoClient

client = MongoClient()
db = client['test']
restaraunts = db['restaraunts']


def print_irish():
    for doc in restaraunts.find({"cuisine": "Irish"}):
        print(doc['name'])


def print_irish_or_russian():
    for doc in restaraunts.find({"$or": [{"cuisine": "Irish"},
                                         {"cuisine": "Russian"}]}):
        print(doc['name'])


def print_with_specific_address():
    doc = restaraunts.find_one(
        {
            "address.building": "284",
            "address.street": "Prospect Park West",
            "address.zipcode": "11215"
        })
    print(doc['name'])


print_irish()
print_irish_or_russian()
print_with_specific_address()

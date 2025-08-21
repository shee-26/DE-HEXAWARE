import json
jsonString = '{"id": 121, "name": "Naveen", "course": "MERN Stack"}'
studentinfo = json.loads(jsonString)
print(studentinfo)
print(studentinfo['id'])

import json
with open('data.json') as Jsonfile:
    data = json.load(Jsonfile)
    print("Type:", type(data))

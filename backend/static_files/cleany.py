import json

with open('coin_data_sevice_json.txt') as f:
    json_data = json.load(f)

    for i in range(1, len(json_data)+1):
        json_data[i-1]['name'] = f"Song {i}"

    with open("coin_data_sevice_json_v1.txt", "w") as outfile:
        json.dump(json_data, outfile)

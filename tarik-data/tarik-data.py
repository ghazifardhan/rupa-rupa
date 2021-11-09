import requests
import pandas as pd
# r = requests.get(url)
# data = r.json()

# itemDicts = []

# for item in data['data']['data']:
#   itemDict = {
#     'name': item['productDTO']['name'],
#     'price': item['price']
#   }
#   itemDicts.append(itemDict)

# df = pd.DataFrame(data=itemDicts)
# df.to_excel('item.xlsx')

n = 1
itemDicts = []
while n > 0:
  
  url = "https://api-v2.segari.id/v1.1/products/price?&agentId=311&categories=sayur&size=40&page=%s&paginationType=slice" % n
  r = requests.get(url)
  data = r.json()

  if (len(data['data']['data']) > 0):
    print('tarik data page %s' % n)
    for item in data['data']['data']:
      itemDict = {
        'name': item['productDTO']['name'],
        'price': item['price'],
        'priceBefore': item['priceBefore'],
        'sellingUnit': item['productDTO']['sellingUnit'],
        'categoryName': item['productDTO']['categoryName'],
        'notes': item['productDTO']['notes'],
      }
      itemDicts.append(itemDict)
  else:
    break

  n = n + 1

df = pd.DataFrame(data=itemDicts)
df.to_excel('item.xlsx')
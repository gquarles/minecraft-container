from bs4 import BeautifulSoup
import requests

response = requests.get('https://www.minecraft.net/en-us/download/server/')

if response.status_code != 200:
    print('Error reaching mojang')
    exit()

page = response.content
soup = BeautifulSoup(page, 'html.parser')

links = soup.findAll('a')

for link in links:
    if str(link.get('href')).endswith('server.jar'):
        download = str(link.get('href'))

response = requests.get(download)

if response.status_code == 200:
    open('server.jar', 'wb').write(response.content)
else:
    print('Error reaching mojang')

# I requested my data from Spotify so that I can analyze and visualize it with Python and Tableau. 

import pandas as pd
import numpy as np
import requests

# First, I need to create a dataframe to hold all of the data that I want to look at.

df_stream0 = pd.read_json('StreamingHistory0.json')
df_stream1 = pd.read_json('StreamingHistory1.json')

my_spotify_data = pd.concat([df_stream0, df_stream1])

# Next ,I want to create a 'UniqueID' for each song by combining the fields 'artistName' and 'trackName'
my_spotify_data['UniqueID'] = my_spotify_data['artistName'] + ":" + my_spotify_data['trackName']

my_spotify_data.head()
#print(my_spotify_data)

# I then needed to create a new file to contain the 'tracks' dictionary from my 'YourLibrary.json' file
# read edited Library json file into a pandas dataframe
my_library = pd.read_json('YourLibrary1.json')

# add UniqueID column (same as above)
my_library['UniqueID'] = my_library['artist'] + ":" + my_library['track']

# add column with track URI stripped of 'spotify:track:'
new = my_library["uri"].str.split(":", expand = True)
my_library['track_uri'] = new[2]

#print(my_library)

# create final dict as a copy df_stream
df_tableau = my_spotify_data.copy()

# add column checking if streamed song is in library
df_tableau['In Library'] = np.where(df_tableau['UniqueID'].isin(my_library['UniqueID'].tolist()),1,0)

# left join with my_library on UniqueID to bring in album and track_uri
df_tableau = pd.merge(df_tableau, my_library[['album','UniqueID','track_uri']],how='left',on=['UniqueID'])

#print(df_tableau)

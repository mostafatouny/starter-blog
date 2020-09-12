---
title: Applying Machine Learning Is Not Enough, Predicting Ratings From Games Genres
subtitle: Do not get captivated if you applied machine learning
summary: Do not get captivated if you applied machine learning
#authors:
#- admin
tags: []
categories: []
date: "2020-03-13T00:00:00Z"
#lastMod: "2019-09-05T00:00:00Z"
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: ""
  focal_point: ""
---

### Preface
In this blog post we fit a _naive Bayes_ model to predict games _critic ratings_ given their genres. Data are scraped from [best metacritic ps4 games](https://www.metacritic.com/browse/games/score/metascore/year/ps4/filtered?year_selected=2019) through a [scrapper of mine](https://github.com/mostafatouny/data-scraper/). We do not claim a result of value. An introductory recommender system course yields results much more accurate and reliable than approach presented here. Why am I doing this then? As machine learning today is overwhelmingly hyped, It is nice to have a facet of it in my portfolio. Jump directly to [discussion](#discussion) to briefly get into the gist of this post.

___

## Table of Contentes
Intro

- [Preface](#preface)


Data Preprocessing

- [Data Cleansing](#data-cleansing)
- [Discretize Critic Rating](#discretize-critic-rating)
- [Obtain Unique Series of Genres](#obtain-unique-series-of-genres)
- [Create Column For Each Genre. Its Value Corresponds To Whether It is in Game's Genres](#create-column-For-each-genre-its-value-corresponds-to-whether-it-is-in-Games-Genres)


Applying Machine Learning

- [Naive Gaussian Bayes](#naive-gaussian-bayes)
- [Predicting Upcoming Games](#predicting-upcoming-games)
- [Discussion](#discussion)

___

### Import Libraries and Local Files


```python
# 3rd-party libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import GaussianNB
# local-files
import jsonRW as jsRW
import discretizeIntoCategories as discIntCat
```

___

## Data Cleansing

### Read Data


```python
# read its local json file
metacritic_json = jsRW.readJson('metacritic2019ps4_data')
# parse it as pandas dataframe, then map platform name to it
df = pd.DataFrame(metacritic_json)
```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>critic_rating</th>
      <th>developer</th>
      <th>genres</th>
      <th>name</th>
      <th>publisher</th>
      <th>release_data</th>
      <th>users_rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>91</td>
      <td>Square Enix</td>
      <td>[Role-Playing, Massively Multiplayer]</td>
      <td>Final Fantasy XIV: Shadowbringers</td>
      <td>Square Enix</td>
      <td>Jul  2, 2019</td>
      <td>8.3</td>
    </tr>
    <tr>
      <th>1</th>
      <td>91</td>
      <td>PlatinumGames</td>
      <td>[Role-Playing, Action RPG]</td>
      <td>NieR: Automata - Game of the YoRHa Edition</td>
      <td>Square Enix</td>
      <td>Feb 26, 2019</td>
      <td>8.5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>91</td>
      <td>Capcom R&amp;D Division 1</td>
      <td>[Action Adventure, Survival]</td>
      <td>Resident Evil 2</td>
      <td>Capcom</td>
      <td>Jan 25, 2019</td>
      <td>8.8</td>
    </tr>
    <tr>
      <th>3</th>
      <td>90</td>
      <td>From Software</td>
      <td>[Action Adventure, General]</td>
      <td>Sekiro: Shadows Die Twice</td>
      <td>Activision</td>
      <td>Mar 22, 2019</td>
      <td>7.9</td>
    </tr>
    <tr>
      <th>4</th>
      <td>89</td>
      <td>Capcom</td>
      <td>[Role-Playing, Action RPG]</td>
      <td>Monster Hunter: World - Iceborne</td>
      <td>Capcom</td>
      <td>Sep  6, 2019</td>
      <td>8.4</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>336</th>
      <td>39</td>
      <td>High Voltage Software</td>
      <td>[Action, Shooter, Shoot-'Em-Up, Top-Down]</td>
      <td>Zombieland: Double Tap - Road Trip</td>
      <td>GameMill Entertainment</td>
      <td>Oct 15, 2019</td>
      <td>4.6</td>
    </tr>
    <tr>
      <th>337</th>
      <td>37</td>
      <td>Square Enix, ilinx inc.</td>
      <td>[Action Adventure, General]</td>
      <td>Left Alive</td>
      <td>Square Enix</td>
      <td>Mar  5, 2019</td>
      <td>8.3</td>
    </tr>
    <tr>
      <th>338</th>
      <td>36</td>
      <td>Void Studios</td>
      <td>[Role-Playing, Action RPG]</td>
      <td>Eternity: The Last Unicorn</td>
      <td>1C Company</td>
      <td>Mar  5, 2019</td>
      <td>3.6</td>
    </tr>
    <tr>
      <th>339</th>
      <td>31</td>
      <td>Dean 'Rocket' Hall</td>
      <td>[Sci-Fi, Action, Shooter, First-Person, Arcade]</td>
      <td>DayZ</td>
      <td>Bohemia Interactive</td>
      <td>May 30, 2019</td>
      <td>2.9</td>
    </tr>
    <tr>
      <th>340</th>
      <td>31</td>
      <td>Wakefield Interactive</td>
      <td>[Puzzle, Action]</td>
      <td>Where the Bees Make Honey</td>
      <td>Wakefield Interactive</td>
      <td>Mar 29, 2019</td>
      <td>3.2</td>
    </tr>
  </tbody>
</table>
<p>341 rows × 7 columns</p>
</div>



___

### Drop Irrelevant Columns


```python
df = df.drop(['developer', 'name', 'publisher', 'release_data', 'users_rating'], axis=1)
```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>critic_rating</th>
      <th>genres</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>91</td>
      <td>[Role-Playing, Massively Multiplayer]</td>
    </tr>
    <tr>
      <th>1</th>
      <td>91</td>
      <td>[Role-Playing, Action RPG]</td>
    </tr>
    <tr>
      <th>2</th>
      <td>91</td>
      <td>[Action Adventure, Survival]</td>
    </tr>
    <tr>
      <th>3</th>
      <td>90</td>
      <td>[Action Adventure, General]</td>
    </tr>
    <tr>
      <th>4</th>
      <td>89</td>
      <td>[Role-Playing, Action RPG]</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>336</th>
      <td>39</td>
      <td>[Action, Shooter, Shoot-'Em-Up, Top-Down]</td>
    </tr>
    <tr>
      <th>337</th>
      <td>37</td>
      <td>[Action Adventure, General]</td>
    </tr>
    <tr>
      <th>338</th>
      <td>36</td>
      <td>[Role-Playing, Action RPG]</td>
    </tr>
    <tr>
      <th>339</th>
      <td>31</td>
      <td>[Sci-Fi, Action, Shooter, First-Person, Arcade]</td>
    </tr>
    <tr>
      <th>340</th>
      <td>31</td>
      <td>[Puzzle, Action]</td>
    </tr>
  </tbody>
</table>
<p>341 rows × 2 columns</p>
</div>



### Critic Rating Data Type To Integer


```python
df.dtypes
```




    critic_rating    object
    genres           object
    dtype: object




```python
df['critic_rating'] = pd.to_numeric(df['critic_rating'])
```


```python
df.dtypes
```




    critic_rating     int64
    genres           object
    dtype: object



___

### Discretize Critic Rating


```python
# categories to be mapped as they fall within certain ranges
categories = pd.Series(["very_low", "low", "moderate", "high", "very_high"])
# critic ratings ranges to be mapped
intervals_categories = [0, 20, 40, 60, 80]
```


```python
# compute categories according to ranges specified
df['category'] = df.apply(discIntCat.numToCat, axis=1, args=('critic_rating', categories, intervals_categories))
# let categories be recognized by pandas
df['category'] = df['category'].astype("category")
# order categories
df['category'] = df['category'].cat.set_categories(categories, ordered=True)    
```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>critic_rating</th>
      <th>genres</th>
      <th>category</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>91</td>
      <td>[Role-Playing, Massively Multiplayer]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>1</th>
      <td>91</td>
      <td>[Role-Playing, Action RPG]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>2</th>
      <td>91</td>
      <td>[Action Adventure, Survival]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>3</th>
      <td>90</td>
      <td>[Action Adventure, General]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>4</th>
      <td>89</td>
      <td>[Role-Playing, Action RPG]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>336</th>
      <td>39</td>
      <td>[Action, Shooter, Shoot-'Em-Up, Top-Down]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>337</th>
      <td>37</td>
      <td>[Action Adventure, General]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>338</th>
      <td>36</td>
      <td>[Role-Playing, Action RPG]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>339</th>
      <td>31</td>
      <td>[Sci-Fi, Action, Shooter, First-Person, Arcade]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>340</th>
      <td>31</td>
      <td>[Puzzle, Action]</td>
      <td>low</td>
    </tr>
  </tbody>
</table>
<p>341 rows × 3 columns</p>
</div>



___

### Drop Critic Rating


```python
df = df.drop(['critic_rating'], axis=1)
```


```python
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>genres</th>
      <th>category</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>[Role-Playing, Massively Multiplayer]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>1</th>
      <td>[Role-Playing, Action RPG]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>2</th>
      <td>[Action Adventure, Survival]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>3</th>
      <td>[Action Adventure, General]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>4</th>
      <td>[Role-Playing, Action RPG]</td>
      <td>very_high</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>336</th>
      <td>[Action, Shooter, Shoot-'Em-Up, Top-Down]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>337</th>
      <td>[Action Adventure, General]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>338</th>
      <td>[Role-Playing, Action RPG]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>339</th>
      <td>[Sci-Fi, Action, Shooter, First-Person, Arcade]</td>
      <td>low</td>
    </tr>
    <tr>
      <th>340</th>
      <td>[Puzzle, Action]</td>
      <td>low</td>
    </tr>
  </tbody>
</table>
<p>341 rows × 2 columns</p>
</div>



___

### Obtain Unique Series of Genres


```python
sr_genres = df['genres']
```


```python
sr_genres
```




    0                [Role-Playing, Massively Multiplayer]
    1                           [Role-Playing, Action RPG]
    2                         [Action Adventure, Survival]
    3                          [Action Adventure, General]
    4                           [Role-Playing, Action RPG]
                                ...                       
    336          [Action, Shooter, Shoot-'Em-Up, Top-Down]
    337                        [Action Adventure, General]
    338                         [Role-Playing, Action RPG]
    339    [Sci-Fi, Action, Shooter, First-Person, Arcade]
    340                                   [Puzzle, Action]
    Name: genres, Length: 341, dtype: object




```python
# concatenate genres lists, then filter duplicated elements
unique_genres = np.unique(np.concatenate(sr_genres, axis=0))
```


```python
unique_genres
```




    array(['2D', '3D', '4X', 'Action', 'Action Adventure', 'Action RPG',
           'Adventure', 'Arcade', 'Automobile', 'Baseball', 'Basketball',
           "Beat-'Em-Up", 'Biking', 'Billiards', 'Boxing / Martial Arts',
           'Business / Tycoon', 'Card Battle', 'Career', 'Civilian', 'Combat',
           'Command', 'Compilation', 'Cricket', 'Dancing', 'Defense',
           'Fantasy', 'Fighting', 'First-Person', 'Flight', 'Football',
           'General', 'Golf', 'Government', 'Ice Hockey', 'Individual',
           'Japanese-Style', 'Light Gun', 'Linear', 'Management', 'Marine',
           'Massively Multiplayer', 'Matching', 'Miscellaneous', 'Music',
           'Open-World', 'Other', 'Party / Minigame', 'Platformer',
           'Point-and-Click', 'Puzzle', 'Racing', 'Real-Time', 'Rhythm',
           'Roguelike', 'Role-Playing', 'Sandbox', 'Sci-Fi', "Shoot-'Em-Up",
           'Shooter', 'Sim', 'Simulation', 'Skate / Skateboard', 'Soccer',
           'Space', 'Sports', 'Strategy', 'Survival', 'Tactical', 'Tactics',
           'Team', 'Third-Person', 'Top-Down', 'Turn-Based', 'Vehicle',
           'Virtual', 'Virtual Life', 'Visual Novel', 'Western-Style',
           'Wrestling'], dtype='<U21')



___

### Remove Spaces, Slashes and Dashes From Genres Names


```python
# spaces, slashes and dashes converter to underscores and empty string
def underscoreCleaner(strLis_in):
    tem_string = strLis_in
    tem_string = tem_string.replace(' ', '_')
    tem_string = tem_string.replace('/', '')
    tem_string = tem_string.replace('-', '_')
    return tem_string
```


```python
temLis = pd.Series(unique_genres)
```


```python
# apply cleaner
temLis = temLis.apply(underscoreCleaner)
```


```python
cleanedUniqueGenres = temLis
```


```python
cleanedUniqueGenres
```




    0                   2D
    1                   3D
    2                   4X
    3               Action
    4     Action_Adventure
                ...       
    74             Virtual
    75        Virtual_Life
    76        Visual_Novel
    77       Western_Style
    78           Wrestling
    Length: 79, dtype: object



___

### Create Column For Each Genre. Its Value Corresponds To Whether It is in Game's Genres


```python
# maps genresList_in to a boolean array, corresponding to whether a genre is in game's genres list
def isGenreIn(row_in, column_in, genresList_in):
    # game's genres list
    row_value = pd.Series(row_in[column_in])
    # all unique genres
    genresSer = pd.Series(genresList_in)
    # check whether each genre in all unique genres is in game's genres list
    # return a boolean array, corresponding to whether genre is found in game's list.
    return genresSer.isin(row_value)
```


```python
# apply above function
genresAsColumns = df.apply(isGenreIn, axis=1, args=('genres', cleanedUniqueGenres))
```


```python
# rename columns to all unique genres
genresAsColumns.columns = cleanedUniqueGenres
```


```python
genresAsColumns
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>2D</th>
      <th>3D</th>
      <th>4X</th>
      <th>Action</th>
      <th>Action_Adventure</th>
      <th>Action_RPG</th>
      <th>Adventure</th>
      <th>Arcade</th>
      <th>Automobile</th>
      <th>Baseball</th>
      <th>...</th>
      <th>Team</th>
      <th>Third_Person</th>
      <th>Top_Down</th>
      <th>Turn_Based</th>
      <th>Vehicle</th>
      <th>Virtual</th>
      <th>Virtual_Life</th>
      <th>Visual_Novel</th>
      <th>Western_Style</th>
      <th>Wrestling</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>336</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>337</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>338</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>339</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>340</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>...</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
  </tbody>
</table>
<p>341 rows × 79 columns</p>
</div>




```python
# map boolean values to integers. True to 1 and False to 0
genresAsColumns = genresAsColumns.astype(int)
```


```python
genresAsColumns
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>2D</th>
      <th>3D</th>
      <th>4X</th>
      <th>Action</th>
      <th>Action_Adventure</th>
      <th>Action_RPG</th>
      <th>Adventure</th>
      <th>Arcade</th>
      <th>Automobile</th>
      <th>Baseball</th>
      <th>...</th>
      <th>Team</th>
      <th>Third_Person</th>
      <th>Top_Down</th>
      <th>Turn_Based</th>
      <th>Vehicle</th>
      <th>Virtual</th>
      <th>Virtual_Life</th>
      <th>Visual_Novel</th>
      <th>Western_Style</th>
      <th>Wrestling</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>336</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>337</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>338</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>339</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>340</th>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>...</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
<p>341 rows × 79 columns</p>
</div>



___

### Map Classes To Their Corresponding Numeric Indices


```python
# a mapper from class string to its index
classesArr = np.array(["very_low", "low", "moderate", "high", "very_high"])
catToIndDict = {"very_low":0, "low":1, "moderate":2, "high":3, "very_high":4}
def catToInd(str_in):
    return catToIndDict[str_in]
```


```python
classes = df['category']
```


```python
classes
```




    0      very_high
    1      very_high
    2      very_high
    3      very_high
    4      very_high
             ...    
    336          low
    337          low
    338          low
    339          low
    340          low
    Name: category, Length: 341, dtype: category
    Categories (5, object): [very_low < low < moderate < high < very_high]




```python
# apply above mapper
classes = classes.apply(lambda x: catToInd(x))
```


```python
classes
```




    0      4
    1      4
    2      4
    3      4
    4      4
          ..
    336    1
    337    1
    338    1
    339    1
    340    1
    Name: category, Length: 341, dtype: category
    Categories (5, int64): [0 < 1 < 2 < 3 < 4]



___

## Naive Gaussian Bayes

### Convert X and Y To Numpy Arrays


```python
genresAsColumns = genresAsColumns.to_numpy()
```


```python
classes = classes.to_numpy()
```


```python
genresAsColumns
```




    array([[0, 0, 0, ..., 0, 0, 0],
           [0, 0, 0, ..., 0, 0, 0],
           [0, 0, 0, ..., 0, 0, 0],
           ...,
           [0, 0, 0, ..., 0, 0, 0],
           [0, 0, 0, ..., 0, 0, 0],
           [0, 0, 0, ..., 0, 0, 0]])




```python
classes
```




    array([4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
           4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
           4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
           4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
           3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2,
           2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
           2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
           2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1])



### Split Data For Testing and Training 


```python
X_train, X_test, y_train, y_test = train_test_split(genresAsColumns, classes, test_size=0.3, random_state=0)
```

### Fit Model


```python
# initialize a guassian model
gnb = GaussianNB()
# fit model games genres and classes
clf = gnb.fit(X_train, y_train)
```

### Predicting Test Data


```python
y_pred = clf.predict(X_test)
```

### Accuracy


```python
# Number of correctly labeled points out of total, respectively
correctlyLabeledNum = (y_test == y_pred).sum()
totalPointsNum = X_test.shape[0]
print("Number of Correctly Labeled: ", correctlyLabeledNum)
print("Number of Total Points: ", totalPointsNum)
```

    Number of Correctly Labeled:  17
    Number of Total Points:  103



```python
print("Accuracy Percentage: ", correctlyLabeledNum/totalPointsNum)
```

    Accuracy Percentage:  0.1650485436893204


___

## Predicting Upcoming Games

### A Mapper From A Series Element To Its Corresponding Index


```python
def indexFromName(series_in, str_in):
    return series_in[series_in == str_in].index[0]
```


```python
indexFromName(cleanedUniqueGenres, '2D')
```




    0



### Construct Array of Indices From Strings


```python
def arrayFromNames(series_in, strLis_in):
    # Initialize an array of 79 zeros, corresponding to genres numbers
    gameGenres = np.array([0] * 79)
    
    # for each input genre, set its corresponding value to 1
    for name in strLis_in:
        gameGenres[indexFromName(series_in, name)] = 1
        
    return gameGenres
```

### Predict Class Name From Genres Strings


```python
def predictClassFromGenres(strLis_in):
    # map genres strings to their corresponding indices
    gameGenreArray = arrayFromNames(cleanedUniqueGenres, strLis_in)
    # prediction of class numeric value
    gamePred = clf.predict([
        gameGenreArray
    ])
    # return predicted class name
    return classesArr[gamePred[0]]
```

___

### Doom Eternal

![doom-eternal](./doom-eternal.png)


```python
predictClassFromGenres(['Action', 'Shooter', 'First_Person', 'Arcade'])
```




    'low'



### Control: The Foundation

![control-the-foundation](./control-the-foundation.png)


```python
predictClassFromGenres(['Action_Adventure', 'General'])
```




    'low'



### Resident Evil 3

![resident-evil-3](./resident-evil-3.png)


```python
predictClassFromGenres(['Action_Adventure', 'Survival'])
```




    'moderate'



___

### Discussion

Let's now analyze the embarrassing results I reached. A realization of ignorance is not as bad as an ignorance of being ignorant. For the latter case, There is no chance for remediation, but for the former, I am skeptic of guaranteed chances.

**There is no pattern to be fitted**. I have seen plenty of computer science students who just care about machine learning models and give no interest to the data itself! That is exactly alike claiming astronomy is all about telescopes. In fact, Data science is all based about our understanding of real-life data and whether we could discover and verify patterns found in them. Machine learning models are toolbox for the data scientist so that he could reveal insights in data, but they are not his principal goal. Regarding our case in this blog post, It is well-known that genres are not indicators of a game's quality at all. If the data contains no pattern, then the hypothesized pattern shall not emerge from whatever model you apply. I would doubt my self in case the model reached a high accuracy rate.

**Features vectors is ridiculously simplifing the item**. Two _action-adventure_ _3rd-person_ games probably have totally different playing-style/theme. Simplifing games by their genres is alike describing a student's skills qualifications through his faculty. Is graduating from CS major an indicator of student's skills? He might be either a lazy or a dedicated student. A curious and challenging inquiry arises here. How do we represent aesthetics in terms of numbers? How do we objectively measure a game's degree of fun? Is it even possible for science to reach at someday objective measures of human-feelings? The only aspect I am sure of is that no one is sure of answers to these questions (sounds like a self-contradictory statement, right?)

Finally, Note that _naive bayes_ is based on the assumption that features are independant from each other, which is not the case here. _Action_ games are more likely to be _adventure_, for instance.

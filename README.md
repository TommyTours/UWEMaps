# UWEMaps

## About
UWEMaps is an iOS app built for my Digital Systems Project/Dissertation for my Computer Science degree at the University of the West of England.
The app uses GPS to take the user on a guided tour of the university campus, providing information about the various departments and facilities that are visited along the way.

## Data
The tour data is stored using the GeoJSON format, with each landmark on the tour represented a points and the routes between them represented as linestrings.
For the purposes of the University project the tour data was saved locally to the device and time, scope and budget did not allow for me to set up a web server to host the data, however the app is designed so that it could be updated in future to fetch it's data from the web, allowing more flexibility in updating.

## Features
The app has two main functions
### Tour
The primary function of the app is to provide the tour of the campus with information about the landmarks being displayed as a modal sheet when the user arrives at said landmark.
### Landmark View
The second function of the app allows users to view the information about the landmarks independently of the tour by selecting the desired landmark from a list.

![instruction updating resized](https://user-images.githubusercontent.com/29551392/132209870-f41b6c6e-f8c6-4aab-9cf4-102afe2b1bbf.png)

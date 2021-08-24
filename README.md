Core Location with api implementation
On the launch of the app an instance of the core location manager is initiated with which the location is handled. So if the user clicks on the button and gives the location access, the app starts reading the location data.
For the API call, Google Firebase database is used with: https://corelocation-703ed-default-rtdb.firebaseio.com/locationData.json
It will have the location data received on change of the significant location.
Crashlytics is added for checking the crashes in teh app if any.

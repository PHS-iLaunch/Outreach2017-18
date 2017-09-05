

/*
 The Models Layer is the middle layer of the app, between the GUI layer and the DB layer. As such, it serves as a "translator" between the GUI's methods, and the Database's pure baseline function, and vice versa.
 
 How?
 
 For every screen on the app (with the exception of the SignIn/SignUp Screens, which are closely connected), there will be a corresponding Model class with a similar name. In each Model class, there will be all the static functions that this specific screen will need in terms of getting data from the DB
 
 In addition to a corresponding to screens, there is also a LaunchModel class that corresponds to any code that runs right when the app launches. Currently, the LaunchModel should check if a currentUsername exists locally. If it does, the first screen should be the Home Screen signed in as the current user. If not, the first screen would be the sign up screen.
 
 
 
 
 
 */

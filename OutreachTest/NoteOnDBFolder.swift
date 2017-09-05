





/*
 The DB layer is the lowest layer of the app. This is the layer that does the most basic storing and fetching of data to and from the database. That means that only the MOST BASELINE methods are used here - no methods specific to the app GUI itself. Additionally, when fetching data, this layer takes the open and non modularized data structure stored in Firebase and encapsulates it into some instance of the 5 objects defined (User,GroupBundle,Group,Event,GroupMember). This would allow for the Model and GUI Layers to use the objects instead of the pure data, which is much cleaner. HOWEVER, the DB layer will never store one of these objects (by unpacking them and turning them into data). These objects' properties should not and cannnot be changed after instantiation. All data stored must be stored point by point as pure data.
 
 
 The layer above this layer is the Model Layer. The DB code should only EVER communicate with the Model Layer, not the GUI Layer.
 
 
 
 Why we should have a delegate: As you can notice, we have a delegate called DBDelegate. So why?
 
 This delegate sets a template for all the baseline methods the database layer will have. Currently, we are using a Firebase Database. However, in the future, it is possible that we may switch away from Firebase to other server side services. So, the methods will stay the same - just the implementations of those methods will be different.
 
 For example, we only have only implementation of the DBDelegate called DBFirebase. This implementation is the code we would use if we are using Firebase as our database. In the future, if we decide to switch, we could create a second implementation such as DBHeroku for example.
 
 
 */

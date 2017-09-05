

/*

The following 5 objects are the only objects that store any data in this app:
    User - This object stores all of data of a single user:
        -username: this is the display name of the user. It does not have to be unique
        -email: this email must be unique to the user and it serves as an ID and the way to reference a specific user in a cluster of data
        -password: the way to authenticate a user during sign in
        -groupBundles: a list of references to all the groups a user is in, as well as group data specific to a user
 
    GroupBundle - This object is a reference to a group specific to a user:
        -groupID: the actual reference to the group stored in the DB
        -color: the color dot displayed for the user on the home page
        -toggled: whether the group events are showed on the calendar
 
    Group - This object stores all of the data of a group:
        -groupID: used to reference the group (and for the GroupBundle to find it). It must be unique for each new group
        -groupName: display name of group
        -groupDescription: description of group
        -groupEvents: list of all events the group has ever created
        -groupMembers: list of all members the group has
 
    Event - This object stores all of the data of an event:
        -eventID: used to reference an event within a group. This ID must be unique within a group
        -eventName: display name of event
        -eventDescription: description of event
        -eventTime: the time the event begins (does not have to be a String)
        -eventLocation: the place the event takes place
        -parentGroupID: used to reference the group the event is in
 
    GroupMember - This object stores all of the data of a group member:
        -username: used to reference the actual User
        -parentGroupID: used to reference the group the member is in
        -position: determines the position of the member in the group. Currently, the two positions are admin and member
 

 ______________
IMPORTANT:
 The only place these classes should EVER be instantiated is within DB. Once the class has been instantiated, ITS PROPERTIES CANNOT BE CHANGED
 
*/

Appirater is an iOS library that let developers ask for reviews from their users.
It prompts to the user and requests him to rate the app, allowing him to choose
between "Rate", "Remind Later" and "No Thanks".

Appirater originally was written by Arash Payan and it is widely used in 
many applications. http://arashpayan.com/blog/2009/09/07/presenting-appirater/

Getting bad reviews by users is very easy and even very good apps get 1 star 
rating from time to time, the idea is to prompt only dedicated user which find 
your app useful and ask them to rate it in a click of a button. Even if a user 
really likes your app it is unlikely that he'll rate it since he needs to go 
through a lot of trouble doing so, Appirater intends to solve this problem.

Appirater allows control over prompting by specifying several arguments that 
intends to select users who find your app useful:
1. Days Count - Number of days the app should be installed
2. Uses Count - Number of times the app was used
3. Significant Events Count - Number of significant events generated

A significant event can be anything that you choose, 
Your app is responsible to flag significant events by calling 
s3eIOSAppiraterUserDidSignificantEvent();

Changes made to the Appirater library -
1. Removed the singleton implementation - had to do that due to some compilation
   problems. There's no need for it since we're using a different interface anyways.
2. Added setParams function to set all params using arguments instead of defines, 
   this is done using s3eIOSAppiraterParams, to prevent the need to re-compile 
   the EDK extension per application. 
3. Split the orignal alert window to 2 seperate windows.
3.1 Orinal Appirater -> "Would you like to rate?" -> YES | NO | REMIND LATER
3.2 This extension -> "Would you like to rate?" -> "Yes" | "No"
3.2.1 User pressed "No" -> "Would you like a reminder?" -> "Yes" | "No"

Interface Functions:
~~~~~~~~~~~~~~~~~~~~
// Call this function on startup with your desired parameters,
// nrSignificantEvents is optional and can be set to -1
// See the use case below to better understand this function.
s3eIOSAppiraterParams(int appId, 
                      int usesUntilPrompt, 
                      int daysUntilPrompt, 
                      int daysRemindLater, 
                      int nrSignificantEvents,
                      const char * dlg_title,
                      const char * dlg_text,
                      const char * dlg_rate_button,
                      const char * remind_dlg_title,
                      const char * remind_dlg_text)


// Call this function at the end of your app's initialization code
// It flags appirater to decrease the UsesCount and then test 
// for prompting, if all conditions are met, the rate app window will be shown.
// canPromptForRating -> if set to false then the rating will be suppressed at app launch.
s3eIOSAppiraterAppLaunched(bool canPromptForRating)

// Tell appirater that the user did a significant event,
// This function increases the SignificantEventsCount and then test 
// for prompting, if all conditions are met, the rate app window will be shown.
// canPromptForRating is described above
s3eIOSAppiraterUserDidSignificantEvent(bool canPromptForRating)

// Should be called when your app is resumed, if you wish to use this function
// It Increments the use count and test if all conditions are met, 
// If so it shows the Rate app prompt
s3eIOSAppiraterAppEnteredForeground(bool canPromptForRating)

// Open the link where the user can write a review, a direct call that doesn't validate 
// whether the conditions are met.
s3eIOSAppiraterRateApp(void)

Usage Example:
~~~~~~~~~~~~~~
This is how I use this EDK extension in my game, Unstoppable Jake.
At the end of init():

    if (s3eDeviceGetInt(S3E_DEVICE_OS) == S3E_OS_ID_IPHONE) {
        s3eIOSAppiraterParams(505967353, 5, 1, 2, 4, 
                              "Rate Unstoppable Jake!", "If you enjoy playing Unstoppable Jake, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!", "Rate It Now",
                              "Rate Later?", "Would you like to rate Unstoppable Jake in a few days?");
        s3eIOSAppiraterAppLaunched(false);
    }

Whenever a user completes a level::

    if (s3eDeviceGetInt(S3E_DEVICE_OS) == S3E_OS_ID_IPHONE) {
        s3eIOSAppiraterUserDidSignificantEvent(true);
    }

Explanation:
~~~~~~~~~~~~
1. I wanted the rate window to appear only when the user have finished a few 
   levels, so I called s3eIOSAppiraterAppLaunched() with canPromptForRating=false, 
   this causes Appirater to increase the use count but not to display the ask
   for rating window at startup.
2. The rest of the params for s3eIOSAppiraterParams() indicates that the rate
   window will not appear unless all of these conditions are met:
2.1 App had been started at least 5 times
2.2 App is installed for at least 1 day
2.3 If user choose "Remind Later", the next reminder will be after 2 days
2.4 The user needs to finish at least 4 levels (the window will appear at
    the completion of the 5th level)

Screenshots:
~~~~~~~~~~~~
See screenshots of my game in the screenshots directory.

Notes
~~~~~
1. The localized language files are not supported yet.
2. Tracking of usage and user choices are saved per version of your 
   app and being completely removed in case your app was deleted.

If you find this useful, please download, enjoy and rate my game ;)
http://itunes.apple.com/us/app/unstoppable-jake/id505967353?mt=8

Cheers,
Guy

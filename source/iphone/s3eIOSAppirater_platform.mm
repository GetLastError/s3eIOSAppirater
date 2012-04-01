/*
 * iphone-specific implementation of the s3eIOSAppirater extension.
 * Add any platform-specific functionality here.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */
#include "s3eIOSAppirater_internal.h"
#include "../../appirater/Appirater.h"

#import <UIKit/UIKit.h>

static Appirater *g_appirater;

s3eResult s3eIOSAppiraterInit_platform()
{
    g_appirater = [[Appirater alloc] init];
    
    // Add any platform-specific initialisation code here
    return S3E_RESULT_SUCCESS;
}

void s3eIOSAppiraterTerminate_platform()
{
    // Add any platform-specific termination code here
    [g_appirater release];
}

void s3eIOSAppiraterParams_platform(int appId, int usesUntilPrompt, int daysUntilPrompt, int daysRemindLater, int nrSignificantEvents, const char * dlg_title, const char * dlg_text, const char * dlg_rate_button, const char * remind_dlg_title, const char * remind_dlg_text)
{
    // Rate window
    NSString *nsDlgTitle = [NSString stringWithUTF8String:dlg_title];
    NSString *nsDlgText = [NSString stringWithUTF8String:dlg_text];
    NSString *nsDlgRate = [NSString stringWithUTF8String:dlg_rate_button];
    // Remind later window
    NSString *nsRemindDlgTitle = [NSString stringWithUTF8String:remind_dlg_title];
    NSString *nsRemindDlgText = [NSString stringWithUTF8String:remind_dlg_text];
    
    [g_appirater setParams: appId : usesUntilPrompt: daysUntilPrompt: daysRemindLater: nrSignificantEvents
                          : nsDlgTitle : nsDlgText : nsDlgRate
                          : nsRemindDlgTitle : nsRemindDlgText];
}

void s3eIOSAppiraterAppLaunched_platform(bool canPromptForRating)
{
    [g_appirater appLaunched: canPromptForRating];
}

void s3eIOSAppiraterAppEnteredForeground_platform(bool canPromptForRating)
{
    [g_appirater appEnteredForeground: canPromptForRating];
}

void s3eIOSAppiraterUserDidSignificantEvent_platform(bool canPromptForRating)
{
    [g_appirater userDidSignificantEvent: canPromptForRating];
}

void s3eIOSAppiraterRateApp_platform()
{
    [g_appirater rateApp];
}

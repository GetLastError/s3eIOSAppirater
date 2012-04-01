/*
 * Internal header for the s3eIOSAppirater extension.
 *
 * This file should be used for any common function definitions etc that need to
 * be shared between the platform-dependent and platform-indepdendent parts of
 * this extension.
 */

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#ifndef S3EIOSAPPIRATER_INTERNAL_H
#define S3EIOSAPPIRATER_INTERNAL_H

#include "s3eTypes.h"
#include "s3eIOSAppirater.h"
#include "s3eIOSAppirater_autodefs.h"


/**
 * Initialise the extension.  This is called once then the extension is first
 * accessed by s3eregister.  If this function returns S3E_RESULT_ERROR the
 * extension will be reported as not-existing on the device.
 */
s3eResult s3eIOSAppiraterInit();

/**
 * Platform-specific initialisation, implemented on each platform
 */
s3eResult s3eIOSAppiraterInit_platform();

/**
 * Terminate the extension.  This is called once on shutdown, but only if the
 * extension was loader and Init() was successful.
 */
void s3eIOSAppiraterTerminate();

/**
 * Platform-specific termination, implemented on each platform
 */
void s3eIOSAppiraterTerminate_platform();
void s3eIOSAppiraterParams_platform(int appId, int usesUntilPrompt, int daysUntilPrompt, int daysRemindLater, int nrSignificantEvents, const char * dlg_title, const char * dlg_text, const char * dlg_rate_button, const char * remind_dlg_title, const char * remind_dlg_text);

void s3eIOSAppiraterAppLaunched_platform(bool canPromptForRating);

void s3eIOSAppiraterAppEnteredForeground_platform(bool canPromptForRating);

void s3eIOSAppiraterUserDidSignificantEvent_platform(bool canPromptForRating);

void s3eIOSAppiraterRateApp_platform();


#endif /* !S3EIOSAPPIRATER_INTERNAL_H */
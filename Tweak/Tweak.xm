#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBUserAgent.h"
 
static BOOL enabled = YES;

%hook SBUIController
- (void)finishLaunching {
	%orig;
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.freemanrepo.sparrowplus.plist"];
	if (![dict objectForKey:@"First Time"]) {
		/*UIModalView *welcomeBadge = [[UIModalView alloc] initWithTitle:@"Welcome to Sparrow+!" buttons:[NSArray arrayWithObjects:@"OK", nil] defaultButtonIndex:0 delegate:nil context:NULL];
		[welcomeBadge setBodyText:@"To make Sparrow the default mail app, go to Settings app and go to Sparrow+ section."];
		[welcomeBadge popupAlertAnimated:YES];
		[welcomeBadge release];*/
		NSBundle *bundle = [[NSBundle alloc] initWithPath:@"/Library/Application Support/Sparrow+/"];
		NSString *title = NSLocalizedStringFromTableInBundle(@"Welcome to Sparrow+!", nil, bundle, @"Welcome to Sparrow+");
		NSString *message = NSLocalizedStringFromTableInBundle(@"To make Sparrow the default mail app, go to Settings app and go to Sparrow+ section.", nil, bundle, @"To make Sparrow the default mail app, go to Settings app and go to Sparrow+ section..");
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Sparrow+" message:@"To make Sparrow the default mail app, go to Settings app and go to Sparrow+ section." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];		
		[alert show];
		[alert release];
		[dict setObject:@"Yep" forKey:@"First Time"];
		[dict writeToFile:@"/private/var/mobile/Library/Preferences/com.freemanrepo.sparrowplus.plist" atomically:YES];
		[bundle releae];
	}
	[dict release];
}
%end
//The following code has been removed in the latest update so I commented it
/*
%hook SBApplication
- (BOOL)supportsVOIPBackgroundMode {
	if ([[self displayIdentifier] isEqualToString:@"com.sparrowmailapp.iphoneapp"]) return YES;
	else return %orig;
}
- (BOOL)backgroundContinuationSupported {
	if ([[self displayIdentifier] isEqualToString:@"com.sparrowmailapp.iphoneapp"]) return YES;
	else return %orig;
}
- (BOOL)backgroundContinuationEnabled {
	if ([[self displayIdentifier] isEqualToString:@"com.sparrowmailapp.iphoneapp"]) return YES;
	else return %orig;
}
- (void)setBackgroundContinuationEnabled:(BOOL)arg1 {
	if ([[self displayIdentifier] isEqualToString:@"com.sparrowmailapp.iphoneapp"]) %orig(YES);
	else return %orig;
}
- (BOOL)backgroundContinuationAvailable {
	if ([[self displayIdentifier] isEqualToString:@"com.sparrowmailapp.iphoneapp"]) return YES;
	else return %orig;
}
- (BOOL)supportsAudioBackgroundMode {
	if ([[self displayIdentifier] isEqualToString:@"com.sparrowmailapp.iphoneapp"]) return YES;
	else return %orig;
}
%end
*/
%hook SpringBoard

- (void)_openURLCore:(id)arg1 display:(id)arg2 publicURLsOnly:(BOOL)arg3 animating:(BOOL)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSURL *url = arg1;
 	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.freemanrepo.sparrowplus.plist"];
 	enabled = [[dict objectForKey:@"Enabled"] boolValue];

	 if (enabled) {
    	if ([url.absoluteString rangeOfString:@"mailto:"].location != NSNotFound) {
        	NSString *URL = [url.absoluteString stringByReplacingOccurrencesOfString:@"mailto:" withString:@"sparrow:"];
        	[(SBUserAgent *)[objc_getClass("SBUserAgent") sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:1 start:0 duration:0.3 animateOut:YES];

    	} else if ([url.absoluteString rangeOfString:@"mailto:"].location != NSNotFound) {
        	NSString *URL = [@"sparrow:" stringByAppendingString:[url.absoluteString stringByReplacingOccurrencesOfString:@"mailto:" withString:@""]];
        	[(SBUserAgent *)[objc_getClass("SBUserAgent") sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:1 start:0 duration:0.3 animateOut:YES];
    	} else { %orig; }
	} else { %orig; }
	[dict release];
}

%end
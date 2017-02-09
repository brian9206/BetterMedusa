/**
 * BetterMedusa
 * Enabling Medusa feature for unsupported device.
 */
#import "BetterMedusaPreference.h"
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBApplication.h>
#import <UIKit/UIKit.h>

%group Medusa

// SBPlatformController
%hook SBPlatformController

- (bool)supportsAllMedusaFeatures {
	return TRUE;
}

- (bool)isMedusaDevice {
	return TRUE;
}

%end

// SBMainWorkspace
%hook SBMainWorkspace

- (bool)isMedusaEnabled {
	return TRUE;
}

%end

// SBMedusaSettings
%hook SBMedusaSettings

- (bool)anyRotationDebuggingEnabled {
	return TRUE;
}

- (bool)enableSideApps {
	return TRUE;
}

- (bool)enablePinningSideApps {
	return TRUE;
}

- (void)setEnableSideApps:(bool)arg1 {
	return %orig;
}

- (void)setEnablePinningSideApps:(bool)arg1 {
	return %orig;
}

%end

// SBApplication
%hook SBApplication

- (bool)isMedusaCapable {	
	// check if SpringBoard
	if ([self isSpringBoard]) {
		return TRUE;
	}
	
	// check if blacklisted
	if ([BetterMedusaPreference isBlacklisted: [self bundleIdentifier]]) {
		return FALSE;
	}
	
	// fix landscape only apps
	NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:[[self path] stringByAppendingString:@"/Info.plist"]];
	if (infoDict == NULL) {
		return %orig;
	}
	
	NSArray *orientations = [infoDict valueForKeyPath:@"UISupportedInterfaceOrientations"];
	if (orientations != NULL && [orientations indexOfObject:@"UIInterfaceOrientationPortrait"] == NSNotFound) {
		return FALSE;
	}
	
	return TRUE;
}

- (bool)_supportsApplicationType:(int)arg1 {
	return TRUE;
}

%end

%hook SpringBoard

-(long long) homeScreenRotationStyle {
	return 2;
}

%end

%end // %group end


%ctor {
	if ([BetterMedusaPreference isEnabled]) {
		%init(Medusa);
	}
}
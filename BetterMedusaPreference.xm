/**
 * BetterMedusa
 * Enabling Medusa feature for unsupported device.
 */
#include "BetterMedusaPreference.h" 

@interface BetterMedusaPreference()
+ (NSDictionary*)getPreferenceValues;
@end
 
@implementation BetterMedusaPreference

+ (NSDictionary*)getPreferenceValues {
	return [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/pw.ssnull.bettermedusa.plist"];
}

+ (bool)isEnabled {
	NSDictionary *keyValues = [BetterMedusaPreference getPreferenceValues];
	
	if (!keyValues) {
		return false;
	}
	
	return [[keyValues objectForKey:@"enable"] boolValue];
}

+ (bool)isBlacklisted:(NSString*)bundleIdentifier {
	NSDictionary *keyValues = [BetterMedusaPreference getPreferenceValues];
	
	if (!keyValues) {
		return false;
	}
	
	NSString *key = @"blacklisted-";
	key = [key stringByAppendingString: bundleIdentifier];
	
	NSString *value = [keyValues objectForKey:key];
	
	if (!value) {
		return false;
	}
	
	return [value boolValue];
}

@end
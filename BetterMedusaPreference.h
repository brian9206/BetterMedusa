/**
 * BetterMedusa
 * Enabling Medusa feature for unsupported device.
 */
@interface BetterMedusaPreference : NSObject

+ (bool)isEnabled;
+ (bool)isBlacklisted:(NSString*)bundleIdentifier;

@end
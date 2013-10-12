//
//  CocoaSyslog.h
//  CocoaSyslog
//
//  Created by Yoann Gini on 20/08/13.
//  Copyright (c) 2013 Yoann Gini. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <syslog.h>

// TODO: complete the Facility list
typedef NS_ENUM(NSInteger, CSLLogFacility)
{
	CSLLogFacilityKernel = LOG_KERN,
	CSLLogFacilityUser = LOG_USER,
	// ...
	CSLLogFacilityMail = LOG_MAIL,
	// ...
	CSLLogFacilityLocal7 = LOG_LOCAL7
};

typedef NS_ENUM(NSInteger, CSLLogLevel)
{
	CSLLogLevel0Emergency = LOG_EMERG,
	CSLLogLevel1Alert = LOG_ALERT,
	CSLLogLevel2Critical = LOG_CRIT,
	CSLLogLevel3Error = LOG_ERR,
	CSLLogLevel4Warning = LOG_WARNING,
	CSLLogLevel5Notice = LOG_NOTICE,
	CSLLogLevel6Info = LOG_INFO,
	CSLLogLevel7Debug = LOG_DEBUG
};

@interface CocoaSyslog : NSObject

+ (CocoaSyslog*)sharedInstance;

- (void)setApplicationIdentity:(NSString*)identity;
- (void)setLogMask:(CSLLogLevel)logmask;
- (void)setFacility:(CSLLogFacility)facility;
- (void)setConsoleOutput:(BOOL)console;

- (void)openLog;
- (void)closeLog;

- (void)message:(NSString*)message withLevel:(CSLLogLevel)logLevel;

/* system is unusable */
- (void)messageLevel0Emergency:(NSString*)format, ...;
/* action must be taken immediately */
- (void)messageLevel1Alert:(NSString*)format, ...;
/* critical conditions */
- (void)messageLevel2Critical:(NSString*)format, ...;
/* error conditions */
- (void)messageLevel3Error:(NSString*)format, ...;
/* warning conditions */
- (void)messageLevel4Warning:(NSString*)format, ...;
/* normal but significant condition */
- (void)messageLevel5Notice:(NSString*)format, ...;
/* informational */
- (void)messageLevel6Info:(NSString*)format, ...;
/* debug-level messages */
- (void)messageLevel7Debug:(NSString*)format, ...;

/* Set Log Level Message */
- (void) setAppLogLevel:(int)logLevel;


@end

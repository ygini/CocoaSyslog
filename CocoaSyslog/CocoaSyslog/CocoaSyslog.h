//
//  CocoaSyslog.h
//  CocoaSyslog
//
//  Created by Yoann Gini on 20/08/13.
//  Copyright (c) 2013 Yoann Gini. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <syslog.h>

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

- (void)messageLevel0Emergency:(NSString*)message;
- (void)messageLevel1Alert:(NSString*)message;
- (void)messageLevel2Critical:(NSString*)message;
- (void)messageLevel3Error:(NSString*)message;
- (void)messageLevel4Warning:(NSString*)message;
- (void)messageLevel5Notice:(NSString*)message;
- (void)messageLevel6Info:(NSString*)message;
- (void)messageLevel7Debug:(NSString*)message;

@end

//
//  CocoaSyslog.m
//  CocoaSyslog
//
//  Created by Yoann Gini on 20/08/13.
//  Copyright (c) 2013 Yoann Gini. All rights reserved.
//

#import "CocoaSyslog.h"

@interface CocoaSyslog ()
{
	BOOL _loggerIsOpen;
	NSString *_applicationIdentity;
	BOOL _consoleLog;
	CSLLogFacility _facility;
}

@end

@implementation CocoaSyslog

+ (CocoaSyslog*)sharedInstance
{
	static CocoaSyslog *sharedInstanceCocoaSyslog = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstanceCocoaSyslog = [CocoaSyslog new];
	});
	
	return sharedInstanceCocoaSyslog;
}

- (void)setApplicationIdentity:(NSString*)identity
{
	if (_loggerIsOpen) {
		return;
	}
	
	@synchronized(_applicationIdentity)
	{
		id oldV = _applicationIdentity;
		_applicationIdentity = [identity copy];
		[oldV release];
	}
}

- (void)setLogMask:(CSLLogLevel)logmask
{
	setlogmask(logmask);
}

- (void)setFacility:(CSLLogFacility)facility
{
	if (_loggerIsOpen) {
		return;
	}
	
	_facility = facility;
}

- (void)setConsoleOutput:(BOOL)console
{
	if (_loggerIsOpen) {
		return;
	}
	
	_consoleLog = console;
}


- (void)openLog
{
	if (!_loggerIsOpen)
	{
		@synchronized(_applicationIdentity)
		{
			openlog([_applicationIdentity cStringUsingEncoding:NSUTF8StringEncoding], _consoleLog ? LOG_CONS : 0 | LOG_PID, _facility);
			_loggerIsOpen = YES;
		}
	}
}

- (void)closeLog
{
	if (_loggerIsOpen) {
		closelog();
		_loggerIsOpen = NO;
	}
}


- (void)message:(NSString*)message withLevel:(CSLLogLevel)logLevel
{
	syslog(logLevel, "%s", [message cStringUsingEncoding:NSUTF8StringEncoding]);
}


- (void)messageLevel0Emergency:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel0Emergency];
}

- (void)messageLevel1Alert:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel1Alert];
}

- (void)messageLevel2Critical:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel2Critical];
}

- (void)messageLevel3Error:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel3Error];
}

- (void)messageLevel4Warning:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel4Warning];
}

- (void)messageLevel5Notice:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel5Notice];
}

- (void)messageLevel6Info:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel6Info];
}

- (void)messageLevel7Debug:(NSString*)message
{
	[self message:message withLevel:CSLLogLevel7Debug];
}


@end

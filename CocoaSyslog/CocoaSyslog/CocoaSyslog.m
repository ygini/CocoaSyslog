//
//  CocoaSyslog.m
//  CocoaSyslog
//
//  Created by Yoann Gini on 20/08/13.
//  Copyright (c) 2013 Yoann Gini. All rights reserved.
//

#import "CocoaSyslog.h"

#include <pthread.h>

@interface CocoaSyslog ()
{
	BOOL _loggerIsOpen;
	NSString *_applicationIdentity;
	BOOL _consoleLog;
	CSLLogFacility _facility;
    
    int selectedLogLevel;
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
	NSAssert(!_loggerIsOpen, @"CocoaSyslog: impossible to change the application name when the logger is open");

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
	NSAssert(!_loggerIsOpen, @"CocoaSyslog: Impossible to change the facility settings when the logger is open!");
	_facility = facility;
}

- (void)setConsoleOutput:(BOOL)console
{
	NSAssert(!_loggerIsOpen, @"CocoaSyslog: Impossible to change the ConsoleOutput settings when the logger is open!");
	_consoleLog = console;
}


- (void)openLog
{
	NSAssert(!_loggerIsOpen, @"CocoaSyslog: Logger already open!");
	@synchronized(_applicationIdentity)
	{
		openlog([_applicationIdentity cStringUsingEncoding:NSUTF8StringEncoding], _consoleLog ? LOG_CONS : 0 | LOG_PID, _facility);
		_loggerIsOpen = YES;
	}
}

- (void)closeLog
{
	NSAssert(_loggerIsOpen, @"CocoaSyslog: Logger already close!");
	closelog();
	_loggerIsOpen = NO;
}


- (void)message:(NSString*)message withLevel:(CSLLogLevel)logLevel
{
	syslog(logLevel, "%s", [[NSString stringWithFormat:@"(%x) %@", pthread_mach_thread_np(pthread_self()), message] cStringUsingEncoding:NSUTF8StringEncoding]);
}

- (void) setAppLogLevel:(int)logLevel
{
#ifndef DEBUG
	setlogmask(logLevel);
#endif
}

- (void)messageLevel0Emergency:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel0Emergency];
	[message release];
    va_end(ap);
}

- (void)messageLevel1Alert:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel1Alert];
	[message release];
    va_end(ap);
}

- (void)messageLevel2Critical:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel2Critical];
	[message release];
    va_end(ap);
}

- (void)messageLevel3Error:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel3Error];
	[message release];
    va_end(ap);
}

- (void)messageLevel4Warning:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel4Warning];
	[message release];
    va_end(ap);
}

- (void)messageLevel5Notice:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel5Notice];
	[message release];
    va_end(ap);
}

- (void)messageLevel6Info:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel6Info];
	[message release];
    va_end(ap);
}

- (void)messageLevel7Debug:(NSString*)format, ...
{
	va_list ap;
    va_start(ap, format);
	NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	[self message:message withLevel:CSLLogLevel7Debug];
	[message release];
    va_end(ap);
}


@end

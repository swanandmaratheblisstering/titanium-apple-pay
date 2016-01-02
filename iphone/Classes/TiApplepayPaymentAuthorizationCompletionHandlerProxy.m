/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiApplepayPaymentAuthorizationCompletionHandlerProxy.h"
#import "TiUtils.h"

@implementation TiApplepayPaymentAuthorizationCompletionHandlerProxy

-(void)dealloc
{
    RELEASE_TO_NIL(_handler);
    [super dealloc];
}

-(void)complete:(id _Nonnull)value
{
    if (_handler != nil) {
        ENSURE_SINGLE_ARG(value, NSNumber);
        
        _handler([TiUtils intValue:value def:PKPaymentAuthorizationStatusFailure]);
    }
}


@end
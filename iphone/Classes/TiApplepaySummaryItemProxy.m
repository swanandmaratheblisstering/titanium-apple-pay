/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiApplepaySummaryItemProxy.h"
#import "TiUtils.h"

@implementation TiApplepaySummaryItemProxy

-(void)dealloc
{
    RELEASE_TO_NIL(item);
    [super dealloc];
}

-(PKPaymentSummaryItem*)item
{
    if (item == nil) {
        item = [PKPaymentSummaryItem new];
    }
    
    return item;
}

#pragma mark Public APIs


-(void)setType:(id)value
{
    ENSURE_TYPE(value, NSNumber);
    [[self item] setType:[TiUtils intValue:value def:PKPaymentSummaryItemTypeFinal]];
}

-(void)setTitle:(id)value
{
    ENSURE_TYPE(value, NSString);
    [[self item] setLabel:[TiUtils stringValue:value]];
}

-(void)setPrice:(id)value
{
    ENSURE_TYPE(value, NSNumber);
    [[self item] setAmount:[self decimalNumber:value]];
}
 
#pragma mark Helper
 
-(NSDecimalNumber*)decimalNumber:(id)value
{
    NSNumber *number = value;
    
    return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
}
 
 @end
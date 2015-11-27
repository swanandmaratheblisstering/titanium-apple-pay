/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiApplepayPaymentDialogProxy.h"
#import "TiApp.h"

@implementation TiApplepayPaymentDialogProxy

-(void)dealloc
{
    RELEASE_TO_NIL(paymentController);
    [super dealloc];
}

-(PKPaymentAuthorizationViewController*)paymentController
{
    if (paymentController == nil) {
        if (paymentRequestProxy == nil) {
            [self throwException:@"Trying to initialize a payment dialog without specifying a payment request: The paymentRequest property is null!" subreason:nil location:CODELOCATION];
            return;
        }
        
        paymentController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:[paymentRequestProxy paymentRequest]];
        [paymentController setDelegate:self];
    }
    
    return paymentController;
}

#pragma mark - Public APIs

-(void)setPaymentRequest:(id)value
{
    paymentRequestProxy = (TiApplepayPaymentRequestProxy*)value;
    [self replaceValue:value forKey:@"paymentRequest" notification:NO];
}

-(void)show:(id)args
{
    id animated = [args valueForKey:@"animated"];
    ENSURE_TYPE_OR_NIL(animated, NSNumber);
    
    [[[[TiApp app] controller] topPresentedController] presentViewController:[self paymentController] animated:[TiUtils boolValue:animated def:YES] completion:nil];
}

#pragma mark - Apple Pay delegates

-(void)paymentAuthorizationViewControllerWillAuthorizePayment:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"willAuthorizePayment");

    if ([self _hasListeners:@"willAuthorizePayment"]) {
        [self fireEvent:@"willAuthorizePayment" withObject:@{}];
    }
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion
{
    NSLog(@"didAuthorizePayment");
    
    if ([self _hasListeners:@"didAuthorizePayment"]) {
        [self fireEvent:@"didAuthorizePayment" withObject:@{}];
    }
    
    completion(PKPaymentAuthorizationStatusSuccess);
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectPaymentMethod:(PKPaymentMethod *)paymentMethod completion:(void (^)(NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    NSLog(@"didSelectPayment");
    
    if ([self _hasListeners:@"didSelectPayment"]) {
        [self fireEvent:@"didSelectPayment" withObject:@{}];
    }
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingContact:(PKContact *)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    NSLog(@"didSelectShippingContact");
    
    if ([self _hasListeners:@"didSelectShippingContact"]) {
        [self fireEvent:@"didSelectShippingContact" withObject:@{}];
    }
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    NSLog(@"didSelectShippingMethod");
    
    if ([self _hasListeners:@"didSelectShippingMethod"]) {
        [self fireEvent:@"didSelectShippingMethod" withObject:@{}];
    }
}

-(void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    NSLog(@"paymentAuthorizationViewControllerDidFinish");

    if ([self _hasListeners:@"didCancel"]) {
        [self fireEvent:@"didCancel" withObject:@{}];
    }
    
    [[self paymentController] dismissViewControllerAnimated:YES completion:nil];
    RELEASE_TO_NIL(paymentController);
}


@end
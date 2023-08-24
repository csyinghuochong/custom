#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface GameIAP : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@end
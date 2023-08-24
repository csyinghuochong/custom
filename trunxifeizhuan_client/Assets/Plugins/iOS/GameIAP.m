#import "GameIAP.h"

#if defined(__cplusplus)
extern "C"{
#endif
	extern void BuyDiamond(const char *diamonID,int count);
	
#if defined(__cplusplus)
}
#endif

#define PRODUCT_COUNT_ZERO "product_count_zero"
#define COMPLETE_TRANSACTION "complete_transaction"
#define FAILED_TRANSACTION "failed_transaction"

//*****************************************************************************

@implementation GameIAP

-(id)init
{
    if ((self = [super init])) {
        //----监听购买结果
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}

-(void)sendMsg2Unity:(const char *)string
{
    UnitySendMessage("main","IosMsg",string);
}

-(void)sendReceipt2Unity:(const char *)string
{
    UnitySendMessage("main","IosReceipt",string);
}

-(void)buy:(const char *)diamonID
{
    NSString *string = [[NSString alloc] initWithUTF8String:diamonID];
    NSSet *nsset = [NSSet setWithObject:string];
    
    NSLog(@"buy:%@", string);
    
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate=self;
    [request start];
}

//收到的产品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    //NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    //NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    //NSLog(@"产品付费数量: %lu", (unsigned long)[myProduct count]);
    
    if([myProduct count]<=0)
    {
        NSLog(@"反馈的产品个数为0");
        
        [self sendMsg2Unity:PRODUCT_COUNT_ZERO];
    }
    else
    {
        SKProduct *product  = [myProduct objectAtIndex:0];
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        
        NSLog(@"---------发送购买请求------------:%@",product.localizedTitle);
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    
    //[request autorelease];
}

-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"---requestDidFinish---");
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"---didFailWithError---:%@",error.description);
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    NSLog(@"-----paymentQueue--------");
    
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"-----交易完成 --------");
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                NSLog(@"-----交易失败 --------");
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                NSLog(@"-----已经购买过该商品 --------");
                [self restoreTransaction:transaction];
            case SKPaymentTransactionStatePurchasing://商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                break;
            case SKPaymentTransactionStateDeferred:
                break;
            default:
                break;
        }
    }
}

// 获取票据信息
- (NSData*)receiptWithTransaction:(SKPaymentTransaction*)transaction {
    NSData *receipt = nil;
    if ([[NSBundle mainBundle] respondsToSelector:@selector(appStoreReceiptURL)]) {
        NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
        receipt = [NSData dataWithContentsOfURL:receiptUrl];
    } else {
        if ([transaction respondsToSelector:@selector(transactionReceipt)]) {
            //Works in iOS3 - iOS8, deprected since iOS7, actual deprecated (returns nil) since iOS9
            receipt = [transaction transactionReceipt];
        }
    }
    return receipt;
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [self sendMsg2Unity:COMPLETE_TRANSACTION];
    
    NSString *encodingReceipt = [[self receiptWithTransaction:transaction] base64EncodedStringWithOptions:0];
    
    NSString *productID = transaction.payment.productIdentifier;
    NSString *transcationID = transaction.transactionIdentifier;
    NSString* key =[transcationID stringByAppendingFormat:@"#%@", productID];
    key = [key stringByAppendingFormat:@"#%@", encodingReceipt];
    [self sendReceipt2Unity:[key UTF8String]];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [self sendMsg2Unity:FAILED_TRANSACTION];
}

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    
}

-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];//解除监听
    //[super dealloc];
}

@end


//*****************************************************************************

#if defined(__cplusplus)
extern "C"{
#endif

	static GameIAP *mGameIAP;

    void InitGameIAP()
    {
        if(mGameIAP==NULL)
        {
            mGameIAP = [[GameIAP alloc]init];
        }
	}
    
	void BuyDiamond(const char *diamonID,int count)
    {   
		InitGameIAP();
        [mGameIAP buy:diamonID];
    }
    
#if defined(__cplusplus)
}
#endif

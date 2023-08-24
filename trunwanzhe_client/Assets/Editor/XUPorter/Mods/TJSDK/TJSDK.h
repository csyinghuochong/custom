

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TJSDK : NSObject
/*!
 @method
 @brief 创建并返回一个单实例对象
 @discussion
 @result TJSDK实例对象
 */
+ (TJSDK *)sharedInstance;

/*!
 @method
 @brief 初始化SDK
 @discussion 失败返回NO,成功返回YES
 @param anAppID 初始化AppID
 @param anRetailerID 初始化零售商ID，目前可以写死为@"1"
 @param anScrectKey RSA加密Key
 @result 初始化是否成功
 */
- (BOOL)registerSDKWithAppID:(NSString *)anAppID andRetailer:(NSString *)anRetailerID andScrectKey:(NSString *)anScrectKey;

/*!
 @method
 @brief 调起登录界面                                                                                                                                                                                                                                                                  
 @discussion
 @param block 登录成功后的处理逻辑
 @param block 试玩登录成功后中断，返回注册的处理逻辑
 @param ifloginself 是否开启自动登录
 
 */
- (void)startLoginAtSuccess:(void (^)(NSDictionary *userObject))succes
                   QuitGame:(void (^)(NSString *reason))quitGame;
/*!
 @method
 @brief 角色信息上报，要求角色信息每次变更的时候调用（比如等级的提升）
 @discussion
 @param zoneid 角色区服id
 @param zonename 角色区服
 @param roleid 角色id
 @param roleLevel 角色等级
 @param roleName 角色名称
 */

- (void)ReportRoleInformationWithZoneId:(NSString *)zoneid
                               ZoneName:(NSString *)zonename
                                 RoleId:(NSString *)roleid
                              RoleLevel:(NSInteger)rolelevel
                               RoleName:(NSString *)rolename;


/*!
 @method
 @brief 调起支付
 @discussion
 @param vorderID 订单id
 @param zoneID 角色区服id
 @param zoneName 角色区服
 @param roleID 角色id
 @param roleLevel 角色等级
 @param roleName 角色名称
 @param appleproductID 苹果产品id
 @param success block 支付成功返回的字符串，block里面处理支付成功的逻辑
 @param falied block 支付失败返回的字符串，block里面处理支付失败的逻辑
 
 */
- (void)payActionWithVorderID:(NSString *)vorderID
                      ZoneID:(NSString *)zoneID
                    ZoneName:(NSString *)zoneName
                      RoleID:(NSString *)roleID
                    RoleLevel:(NSInteger)roleLevel
                    RoleName:(NSString *)roleName
               AppleProductID:(NSString *)appleproductID
                      Success:(void (^)(NSString *result))success
                        falid:(void (^)(NSString *result))failed;



/*!
 @method
 @brief 支付回调
 */
- (void)willEnterForeground;
- (void)handelOpen:(NSURL *)url;

@end


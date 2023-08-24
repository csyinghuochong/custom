#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <err.h>

#define MakeStringCopy( _x_ ) ( _x_ != NULL && [_x_ isKindOfClass:[NSString class]] ) ? strdup( [_x_ UTF8String] ) : NULL

@interface UnityXcodeInteractive : NSObject
@end

@implementation UnityXcodeInteractive

- ( void ) imageSaved: ( UIImage *) image didFinishSavingWithError:( NSError *)error  
          contextInfo: ( void *) contextInfo  
{  
    if (error != nil)  
    {  
        //NSLog(@"有错误");
    }  
    else  
    {  
        //NSLog(@"保存结束");
    }  
} 

+ (const char* )IOSGetIPv6:(const char *)mHost
{
	if( nil == mHost )
		return NULL;
	const char *newChar = "No";
	struct addrinfo* res0;
	struct addrinfo hints;
	struct addrinfo* res;
	int n, s;
	
	memset(&hints, 0, sizeof(hints));
	
	hints.ai_flags = AI_DEFAULT;
	hints.ai_family = PF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	
	if((n=getaddrinfo(mHost, "http", &hints, &res0))!=0)
	{
		printf("getaddrinfo error: %s\n",gai_strerror(n));
		return NULL;
	}
	
	struct sockaddr_in6* addr6;
	struct sockaddr_in* addr;
	NSString * NewStr = NULL;
	char ipbuf[32];
	s = -1;
	for(res = res0; res; res = res->ai_next)
	{
		if (res->ai_family == AF_INET6)
		{
			addr6 =( struct sockaddr_in6*)res->ai_addr;
			newChar = inet_ntop(AF_INET6, &addr6->sin6_addr, ipbuf, sizeof(ipbuf));
			NSString * TempA = [[NSString alloc] initWithCString:(const char*)newChar 
encoding:NSASCIIStringEncoding];
			NSString * TempB = [NSString stringWithUTF8String:"&ipv6"];
			
			NewStr = [TempA stringByAppendingString: TempB];
			//printf("%s\n", newChar);
		}
		else
		{
			addr =( struct sockaddr_in*)res->ai_addr;
			newChar = inet_ntop(AF_INET, &addr->sin_addr, ipbuf, sizeof(ipbuf));
			NSString * TempA = [[NSString alloc] initWithCString:(const char*)newChar 
encoding:NSASCIIStringEncoding];
			NSString * TempB = [NSString stringWithUTF8String:"&ipv4"];
			
			NewStr = [TempA stringByAppendingString: TempB];			
			//printf("%s\n", newChar);
		}
		break;
	}
	
	
	freeaddrinfo(res0);
	
	//printf("getaddrinfo OK");
	
	NSString * mIPaddr = NewStr;
	return MakeStringCopy(mIPaddr);
}

@end

#if defined(__cplusplus)
extern "C"{
#endif
    extern void IOSSaveImageToGallery(const char *path);
	extern void IOSGotoAppStore();
	extern const char* IOSGetIPv6(const char *mHost);
	extern const char* IOSGetCustomPlatform();
    
#if defined(__cplusplus)
}
#endif


#if defined(__cplusplus)
extern "C"{
#endif    
    void IOSSaveImageToGallery(const char *path)
    {
        NSString *strReadAddr = [NSString stringWithUTF8String:path];
        UIImage* image = [UIImage imageWithContentsOfFile:strReadAddr];
        UnityXcodeInteractive *instance = [UnityXcodeInteractive alloc];
        UIImageWriteToSavedPhotosAlbum(image, instance,@selector(imageSaved:didFinishSavingWithError:contextInfo:), nil);
    }
	
	void IOSGotoAppStore()
	{
		NSString *appid = @"1214201079";
		NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",appid ];
		NSURL *url = [NSURL URLWithString:str];
	    [[UIApplication sharedApplication] openURL:url];
	}
	
	const char* IOSGetIPv6(const char *host)
	{
		return [UnityXcodeInteractive IOSGetIPv6:host];
	}
	
	const char* IOSGetCustomPlatform()
	{
        NSString *platform = @"";
		return MakeStringCopy(platform);
	}
    
#if defined(__cplusplus)
}
#endif
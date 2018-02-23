//
//  NIMAVChatController.h
//  NIM
//

#import <UIKit/UIKit.h>
#import "NIMModel.h"
#import "NTESClientUtil.h"
typedef void(^SUCCESS) (id param);
typedef void(^ERROR)(NSString *error);
@interface NIMAVChatController : UIViewController

@property (copy, nonatomic) NSString *strAccount;
@property (copy, nonatomic) NSString *strToken;

+(instancetype)initWithController;
-(instancetype)initWithNIMController;
-(void)addDelegate;
@end

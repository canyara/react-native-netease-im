//
//  NIMAVChatController.h
//  NIM
//

#import <UIKit/UIKit.h>
#import "NIMModel.h"
#import "NTESClientUtil.h"
#import "NTESGLView.h"
typedef void(^SUCCESS) (id param);
typedef void(^ERROR)(NSString *error);
@interface NIMAVChatController : UIViewController

+(instancetype)initWithController;
@property(nonatomic,strong)NTESGLView* regView;
@property(nonatomic,strong)NIMNetCallMeeting *currentMeeting;
-(instancetype)initWithNIMController;
-(void)addDelegate;
-(void)registNTESGLView:(NTESGLView*)view;
-(void)joinMeeting:(NSString*)name resolve:(SUCCESS)resolve reject:(ERROR)reject;
-(void)leaveMeeting;
//收到用户加入通知
-(void)onUserJoined:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting;
//用户离开通知
-(void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting;
-(void)onBypassStreamingStatus:(NIMBypassStreamingStatus)code;
//会议发生错误
-(void)onMeetingError:(NSError *)error meeting:(NIMNetCallMeeting *)meeting;
@end

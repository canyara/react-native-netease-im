//
//  NIMAVChatController.m
//  NIM
//

#import "NIMAVChatController.h"
#import "ContactViewController.h"

@interface NIMAVChatController ()<NIMNetCallManagerDelegate>{
//    BOOL isLoginFailed;
}

@end

@implementation NIMAVChatController
+(instancetype)initWithController{
    static NIMAVChatController *nimVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nimVC = [[NIMAVChatController alloc]init];
    });
    return nimVC;
}
-(instancetype)initWithNIMController{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)addDelegate{
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)registNTESGLView:(NTESGLView*)view{
    self.regView = view;
}

-(void) joinMeeting:(NSString*)name
             resolve:(SUCCESS)resolve
            reject:(ERROR)reject
{
    //初始化会议
    NIMNetCallMeeting *meeting = [[NIMNetCallMeeting alloc] init];
    //指定会议名
    meeting.name = name;
    meeting.type = NIMNetCallMediaTypeVideo;
    meeting.actor = NO;
    
    //加入会议
    [[NIMAVChatSDK sharedSDK].netCallManager joinMeeting:meeting completion:^(NIMNetCallMeeting * _Nonnull meeting, NSError * _Nonnull error) {
        //加入会议失败
        if (error) {
            reject(error.localizedDescription);
        }
        //加入会议成功
        else
        {
            self.currentMeeting = meeting;
            resolve(name);
        }
    }];
}

-(void) leaveMeeting{
    if(self.currentMeeting == nil){
        return;
    }
    
    //获取当前会议
    NIMNetCallMeeting *meeting = self.currentMeeting;
    
    //离开当前多人会议
    [[NIMAVChatSDK sharedSDK].netCallManager leaveMeeting:meeting];
    self.currentMeeting = nil;
}

#pragma mark - NIMNetCallManagerDelegate
- (void)dealloc{
    [[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
}

- (void)onRemoteYUVReady:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                    from:(NSString *)user
{
    if(self.regView != nil){
        [self.regView render:yuvData width:width height:height];
    }
}

//收到用户加入通知
- (void)onUserJoined:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting
{
    //连麦成功
}

//用户离开通知
- (void)onUserLeft:(NSString *)uid meeting:(NIMNetCallMeeting *)meeting
{
    //用户已退出连麦 刷新UI
}

- (void)onBypassStreamingStatus:(NIMBypassStreamingStatus)code
{
    NSString *strStatus = [NSString stringWithFormat:@"%d",(int)code];
    
    [NIMModel initShareMD].avchatStatus = strStatus;
}

//会议发生错误
- (void)onMeetingError:(NSError *)error meeting:(NIMNetCallMeeting *)meeting
{
    //互动直播发生错误 刷新UI
    [NIMModel initShareMD].avchatError = error.localizedDescription;
}

@end

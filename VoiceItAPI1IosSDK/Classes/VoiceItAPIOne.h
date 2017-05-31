//
//  VoiceItAPIOne.h
//  Pods
//
//  Created by Armaan Bindra on 5/31/17.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VoiceItAPIOne : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
typedef enum { enrollment, authentication } RecordingType;
@property (nonatomic, strong) NSString *developerId;
@property (nonatomic, strong) NSString *recordingFilePath;
@property (nonatomic, strong) NSString *contentLanguage;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) AVAudioRecorder * recorder;
@property RecordingType recType;
@property (nonatomic, copy) void (^enrollmentCompleted)(NSString * result);
@property (nonatomic, copy) void (^authenticationCompleted)(NSString * result);
@property (nonatomic, copy) void (^recordingCompleted)();
- (id)init:(NSString *)developerId;
    
#pragma mark - User API Calls
- (void)createUser:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback;
- (void)getUser:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback;
- (void)deleteUser:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback;
    
#pragma mark - Enrollment API Calls
- (void)createEnrollment:(NSString *)userId
                password:(NSString *)password
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback;

- (void)createEnrollment:(NSString *)userId
                password:(NSString *)password
         contentLanguage:(NSString*)contentLanguage
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback;
    
- (void)createEnrollmentByURL:(NSString *)userId password:(NSString *)password audioURL:(NSString *)audioURL callback:(void (^)(NSString *))callback;

- (void)createEnrollment:(NSString *)userId password:(NSString *)password contentLanguage:(NSString*)contentLanguage recordingFinished:(void (^)(void))recordingFinished callback:(void (^)(NSString *))callback;
    
- (void)createEnrollment:(NSString *)userId
                    password:(NSString *)password
           recordingFinished:(void (^)(void))recordingFinished
                    callback:(void (^)(NSString *))callback;
    
- (void)getEnrollments:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback;
- (void)deleteEnrollment:(NSString *)userId password:(NSString *)password enrollmentId:(NSString *)enrollmentId callback:(void (^)(NSString *))callback;
    
#pragma mark - Authentication API Calls
- (void)authentication:(NSString *)userId
                password:(NSString *)password
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback;
- (void)authenticationByURL:(NSString *)userId password:(NSString *)password audioURL:(NSString *)audioURL callback:(void (^)(NSString *))callback;
- (void)authentication:(NSString *)userId
                password:(NSString *)password
         contentLanguage:(NSString*)contentLanguage
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback;
- (void)authentication:(NSString *)userId password:(NSString *)password contentLanguage:(NSString*)contentLanguage recordingFinished:(void (^)(void))recordingFinished callback:(void (^)(NSString *))callback;
- (void)authentication:(NSString *)userId password:(NSString *)password recordingFinished:(void (^)(void))recordingFinished callback:(void (^)(NSString *))callback;
@end

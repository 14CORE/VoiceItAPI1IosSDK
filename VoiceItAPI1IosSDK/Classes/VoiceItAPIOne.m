//
//  VoiceItAPIOne.m
//  Pods
//
//  Created by Armaan Bindra on 5/31/17.
//
//

#import "VoiceItAPIOne.h"
#import <CommonCrypto/CommonDigest.h>
NSString * const host = @"https://siv.voiceprintportal.com/sivservice/api/";

@implementation VoiceItAPIOne
    - (id)init:(NSString *)developerId {
        self.developerId = developerId;
        self.contentLanguage = @"";
        self.userId = @"";
        self.password = @"";
        return self;
    }

-(NSString*)buildURL:(NSString*)endpoint
{
        return [[NSString alloc] initWithFormat:@"%@%@", host, endpoint];
}

- (NSString *)sha256:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG) data.length, digest);
    NSMutableString *output =
    [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

#pragma mark - User API Calls
- (void)createUser:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
    [request addValue:userId forHTTPHeaderField:@"UserId"];
    [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];

    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response,
                                   NSError *error) {

                   NSString *result =
                   [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
                   NSLog(@"createUser Called and Returned: %@", result);
                   callback(result);
               }];
    [task resume];
}

- (void)getUser:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
    [request addValue:userId forHTTPHeaderField:@"UserId"];
    [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];

    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response,
                                   NSError *error) {

                   NSString *result =
                   [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
                   NSLog(@"getUser Called and Returned: %@", result);
                   callback(result);
               }];
    [task resume];
}

- (void)deleteUser:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"DELETE"];
    [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
    [request addValue:userId forHTTPHeaderField:@"UserId"];
    [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];

    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response,
                                   NSError *error) {

                   NSString *result =
                   [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
                   NSLog(@"deleteUser Called and Returned: %@", result);
                   callback(result);
               }];
    [task resume];
}

#pragma mark - Enrollment API Calls

- (void)createEnrollment:(NSString *)userId
                password:(NSString *)password
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback
    {
        [self createEnrollment:userId password:password contentLanguage:@"" audioPath:audioPath callback:callback];
    }

- (void)createEnrollment:(NSString *)userId
                password:(NSString *)password
         contentLanguage:(NSString*)contentLanguage
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback
    {
        _userId = userId;
        _password = password;
        _contentLanguage = contentLanguage;
        _enrollmentCompleted = callback;
        [self createEnrollment:audioPath];
    }

- (void)createEnrollmentByURL:(NSString *)userId password:(NSString *)password audioURL:(NSString *)audioURL callback:(void (^)(NSString *))callback{
    [self createEnrollmentByURL:userId password:password contentLanguage:@"" audioURL:audioURL callback:callback];
}

- (void)createEnrollmentByURL:(NSString *)userId password:(NSString *)password contentLanguage:(NSString*)contentLanguage audioURL:(NSString *)audioURL callback:(void (^)(NSString *))callback{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"enrollments/bywavurl"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
    [request addValue:userId forHTTPHeaderField:@"UserId"];
    [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:audioURL forHTTPHeaderField:@"VsitwavURL"];
    [request addValue:contentLanguage forHTTPHeaderField:@"ContentLanguage"];

    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response,
                                   NSError *error) {

                   NSString *result =
                   [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
                   NSLog(@"createEnrollmentByURL Called and Returned: %@", result);
                   callback(result);
               }];
    [task resume];
}

- (void)createEnrollment:(NSString *)userId
                password:(NSString *)password
              contentLanguage:(NSString*)contentLanguage
            recordingFinished:(void (^)(void))recordingFinished
                     callback:(void (^)(NSString *))callback
    {
        _userId = userId;
        _password = password;
        _contentLanguage = contentLanguage;
        _recType = enrollment;
        _enrollmentCompleted = callback;
        _recordingCompleted = recordingFinished;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self recordAudio];
        });

    }

    - (void)createEnrollment:(NSString *)userId
                    password:(NSString *)password
           recordingFinished:(void (^)(void))recordingFinished
                    callback:(void (^)(NSString *))callback
    {
        [self createEnrollment:userId password:password contentLanguage:@"" recordingFinished:recordingFinished callback:callback];
    }

- (void)createEnrollment:(NSString *)enrollmentPath
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"enrollments"]]];
        NSURLSession *session = [NSURLSession sharedSession];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
        [request addValue:_userId forHTTPHeaderField:@"UserId"];
        [request addValue:[self sha256:_password] forHTTPHeaderField:@"VsitPassword"];
        [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
        [request addValue:_contentLanguage forHTTPHeaderField:@"ContentLanguage"];
        [request
         setHTTPBody:[[NSData alloc] initWithContentsOfFile:enrollmentPath]];
        NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                       NSString *result =
                       [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
                       NSLog(@"createEnrollment Called and Returned: %@", result);
                       [[NSFileManager defaultManager] removeItemAtPath:enrollmentPath error:nil];
                       if(self.enrollmentCompleted){
                           self.enrollmentCompleted(result);
                       }
                   }];
        [task resume];
    }

    - (void)getEnrollments:(NSString *)userId password:(NSString *)password callback:(void (^)(NSString *))callback{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"enrollments"]]];
        NSURLSession *session = [NSURLSession sharedSession];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
        [request addValue:userId forHTTPHeaderField:@"UserId"];
        [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
        [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];

        NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                       NSString *result =
                       [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
                       NSLog(@"getEnrollments Called and Returned: %@", result);
                       callback(result);
                   }];
        [task resume];
    }

    - (void)deleteEnrollment:(NSString *)userId password:(NSString *)password enrollmentId:(NSString *)enrollmentId callback:(void (^)(NSString *))callback{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@/%@",[self buildURL:@"enrollments"], enrollmentId]]];
        NSURLSession *session = [NSURLSession sharedSession];
        [request setHTTPMethod:@"DELETE"];
        [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
        [request addValue:userId forHTTPHeaderField:@"UserId"];
        [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
        [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];

        NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                       NSString *result =
                       [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
                       NSLog(@"deleteEnrollment Called and Returned: %@", result);
                       callback(result);
                   }];
        [task resume];
    }

# pragma mark Authentication API Calls

- (void)authenticationByURL:(NSString *)userId password:(NSString *)password audioURL:(NSString *)audioURL callback:(void (^)(NSString *))callback{
    [self authenticationByURL:userId password:password contentLanguage:@"" audioURL:audioURL callback:callback];
}

- (void)authenticationByURL:(NSString *)userId password:(NSString *)password contentLanguage:(NSString*)contentLanguage audioURL:(NSString *)audioURL callback:(void (^)(NSString *))callback{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"authentications/bywavurl"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
    [request addValue:userId forHTTPHeaderField:@"UserId"];
    [request addValue:[self sha256:password] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:audioURL forHTTPHeaderField:@"VsitwavURL"];
    [request addValue:contentLanguage forHTTPHeaderField:@"ContentLanguage"];

    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response,
                                   NSError *error) {

                   NSString *result =
                   [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
                   NSLog(@"authenticationByURL Called and Returned: %@", result);
                   callback(result);
               }];
    [task resume];
}

- (void)authentication:(NSString *)userId
                password:(NSString *)password
         contentLanguage:(NSString*)contentLanguage
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback
    {
        _userId = userId;
        _password = password;
        _contentLanguage = contentLanguage;
        _authenticationCompleted = callback;
        [self authentication:audioPath];
    }

- (void)authentication:(NSString *)userId
                password:(NSString *)password
               audioPath:(NSString *)audioPath
                callback:(void (^)(NSString *))callback
    {
        [self authentication:userId password:password contentLanguage:@"" audioPath:audioPath callback:callback];
    }

- (void)authentication:(NSString *)userId
                password:(NSString *)password
         contentLanguage:(NSString*)contentLanguage
       recordingFinished:(void (^)(void))recordingFinished
                callback:(void (^)(NSString *))callback
    {
        _userId = userId;
        _password = password;
        _contentLanguage = contentLanguage;
        _recType = authentication;
        _authenticationCompleted = callback;
        _recordingCompleted = recordingFinished;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self recordAudio];
        });
    }

    - (void)authentication:(NSString *)userId
                    password:(NSString *)password
           recordingFinished:(void (^)(void))recordingFinished
                    callback:(void (^)(NSString *))callback
    {
        [self authentication:userId password:password contentLanguage:@"" recordingFinished:recordingFinished callback:callback];
    }

- (void)authentication:(NSString *)authPath
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                        initWithURL:[[NSURL alloc] initWithString:[self buildURL:@"authentications"]]];
        NSURLSession *session = [NSURLSession sharedSession];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request addValue:@"26" forHTTPHeaderField:@"PlatformID"];
        [request addValue:_userId forHTTPHeaderField:@"UserId"];
        [request addValue:[self sha256:_password] forHTTPHeaderField:@"VsitPassword"];
        [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
        [request addValue:_contentLanguage forHTTPHeaderField:@"ContentLanguage"];
        [request
         setHTTPBody:[[NSData alloc] initWithContentsOfFile:authPath]];
        NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                       NSString *result =
                       [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
                       NSLog(@"authentication Called and Returned: %@", result);
                       [[NSFileManager defaultManager] removeItemAtPath:authPath error:nil];
                       if(self.authenticationCompleted){
                           self.authenticationCompleted(result);
                       }
                   }];
        [task resume];
    }

-(void)recordAudio{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&err];
    if (err)
    {
        NSLog(@"%@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
    }
    err = nil;
    if (err)
    {
        NSLog(@"%@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
    }

    NSDictionary *recordSettings = [[NSDictionary alloc]
                                    initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat:11025.0], AVSampleRateKey,
                                    [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
                                    [NSNumber numberWithInt:8], AVLinearPCMBitDepthKey,
                                    [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                    [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
                                    [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey, nil];

    // Unique recording URL
    NSString *fileName = @"RecordedFile"; // Changed it So It Keeps Replacing File
    _recordingFilePath = [NSTemporaryDirectory()
                          stringByAppendingPathComponent:[NSString
                                                          stringWithFormat:@"%@.wav", fileName]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:_recordingFilePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:_recordingFilePath
                                                   error:nil];
    }

    NSURL *url = [NSURL fileURLWithPath:_recordingFilePath];

    err = nil;
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&err];
    if(!_recorder){
        NSLog(@"recorder: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
    }
    [_recorder setDelegate:self];
    [_recorder prepareToRecord];
    [_recorder recordForDuration:5.0];
}

#pragma mark - AVAudioRecorderDelegate Methods

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
    if(err){
        NSLog(@"Setting Category Error:%@", err.localizedDescription);
    }

    [audioSession setActive:NO error:&err];

    NSURL *url = [NSURL fileURLWithPath: _recordingFilePath];
    err = nil;
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    if(!audioData) {
        NSLog(@"audio data: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
    }

    if (self.recordingCompleted){
        self.recordingCompleted();
    }

    switch (_recType) {
        case enrollment:
        [self createEnrollment:_recordingFilePath];
        break;
        case authentication:
        [self authentication: _recordingFilePath];
        break;
        default:
        break;
    }

}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
    {
        NSLog(@"fail because %@", error.localizedDescription);
    }
@end

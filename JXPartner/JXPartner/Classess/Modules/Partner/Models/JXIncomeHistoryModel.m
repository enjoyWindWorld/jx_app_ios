//
//  JXIncomeHistoryModel.m
//  JXPartner
//
//  Created by windpc on 2017/8/24.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXIncomeHistoryModel.h"

@implementation JXIncomeHistoryModel




-(NSArray *)viewItemArr{

    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    
    [arr addObject:@{HIS_LEFT_KEY:@"提现银行",HIS_RIGHT_KEY:@"支付宝"}];
    
    [arr addObject:@{HIS_LEFT_KEY:@"提现银行:",HIS_RIGHT_KEY:@"支付宝"}];
    
    [arr addObject:@{HIS_LEFT_KEY:@"提现时间:",HIS_RIGHT_KEY:self.add_time}];
    
    if (_withdrawal_state == Withdrawal_State_Initiate) {
        
        [arr addObject:@{HIS_LEFT_KEY:@"预计审核时间:",HIS_RIGHT_KEY:self.audit_time}];
        [arr addObject:@{HIS_LEFT_KEY:@"交易单号:",HIS_RIGHT_KEY:self.withdrawal_order}];
        
    }
    if (_withdrawal_state == Withdrawal_State_AuditSuccess) {
        
        [arr addObject:@{HIS_LEFT_KEY:@"审核时间:",HIS_RIGHT_KEY:self.audit_time}];
        
        [arr addObject:@{HIS_LEFT_KEY:@"预计到账时间:",HIS_RIGHT_KEY:self.arrive_time}];
        [arr addObject:@{HIS_LEFT_KEY:@"交易单号:",HIS_RIGHT_KEY:self.withdrawal_order}];
    }
    if (_withdrawal_state == Withdrawal_State_AuditFailere) {
        
        [arr addObject:@{HIS_LEFT_KEY:@"审核时间:",HIS_RIGHT_KEY:self.audit_time}];
       
        [arr addObject:@{HIS_LEFT_KEY:@"失败原因:",HIS_RIGHT_KEY:self.withdrawal_reason}];
        
        [arr addObject:@{HIS_LEFT_KEY:@"交易单号:",HIS_RIGHT_KEY:self.withdrawal_order}];
    }
    if (_withdrawal_state == Withdrawal_State_Success) {
        
        [arr addObject:@{HIS_LEFT_KEY:@"审核时间:",HIS_RIGHT_KEY:self.audit_time}];
       
        [arr addObject:@{HIS_LEFT_KEY:@"到账时间:",HIS_RIGHT_KEY:self.arrive_time}];
        
        [arr addObject:@{HIS_LEFT_KEY:@"交易单号:",HIS_RIGHT_KEY:self.withdrawal_order}];
    }
    if (_withdrawal_state == Withdrawal_State_Failere) {
        
        [arr addObject:@{HIS_LEFT_KEY:@"审核时间:",HIS_RIGHT_KEY:self.audit_time}];
        [arr addObject:@{HIS_LEFT_KEY:@"失败原因:",HIS_RIGHT_KEY:self.withdrawal_reason}];
        [arr addObject:@{HIS_LEFT_KEY:@"交易单号:",HIS_RIGHT_KEY:self.withdrawal_order}];
    }
  
    return  arr ;
}


@end

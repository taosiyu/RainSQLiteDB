//
//  SQLiteBind.h
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/17.
//  Copyright © 2017年 ncm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteBind : NSObject

+(void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt*)pStmt;

@end

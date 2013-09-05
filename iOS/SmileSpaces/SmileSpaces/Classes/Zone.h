//
//  Parada.h
//  ValenciaBusLite
//
//  Created by Isaac Roldan Armengol on 30/07/13.
//  Copyright (c) 2013 Isaac Roldan Armengol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <ADMapCluster.h>

@interface Zone : NSObject <MKAnnotation>{
}

@property (nonatomic,strong) NSNumber *lat;
@property (nonatomic,strong) NSNumber *lon;
@property (nonatomic,strong) NSNumber *smileValue;
@property (nonatomic,strong) NSString *zoneId;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) NSDictionary *zoneDict;



-(id)initWithDict:(NSDictionary *)dict;

@end

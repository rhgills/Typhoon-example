////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import <SenTestingKit/SenTestingKit.h>
#import "PFWeatherReportDao.h"
#import "PFWeatherReport.h"
#import "RXMLElement+PFWeatherReport.h"
#import "Typhoon.h"

@interface PFWeatherReportDaoTests : SenTestCase
@end

@implementation PFWeatherReportDaoTests
{
    id <PFWeatherReportDao> weatherReportDao;
    PFWeatherReport* testReport;
}

- (void)setUp
{
    TyphoonXmlComponentFactory* factory = [[TyphoonXmlComponentFactory alloc] initWithConfigFileName:@"CoreComponents.xml"];
    weatherReportDao = [factory componentForType:@protocol(PFWeatherReportDao)];

    NSString* xmlString = [[TyphoonBundleResource withName:@"SampleForecast.xml" inBundle:[NSBundle bundleForClass:[self class]]] asString];
    RXMLElement* xmlElement = [RXMLElement elementFromXMLString:xmlString encoding:NSUTF8StringEncoding];
    testReport = [xmlElement asWeatherReport];
}


- (void)test_should_allow_saving_a_serialized_report_stream_and_then_retrieving_it
{

    [weatherReportDao saveReport:testReport];

    PFWeatherReport* weatherReport = [weatherReportDao getReportForCityName:@"Manila"];
    assertThat(weatherReport, notNilValue());

}


@end
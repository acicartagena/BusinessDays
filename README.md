# BusinessDays

## App
BusinessDays is an iOS app that calculates business days between 2 dates (From date and To date). Date Computations don't include both the From and To Date. They are based on the Foundation framework's Gregorian calendar implementation. NSW holidays are used for the holiday computations.

### List of included NSW holidays
* New Year - January 1, will have an additional holiday if this falls on a weekend
* Australia Day - January 26, will have an additional holiday if this falls on a weekend
* Anzac Day - April 25
* Queen's Birthday - 2nd Monday of June
* Labour Day - 1st Monday of October
* Christmas Day - December 25, will have an additional holiday if this falls on a weekend
* Boxing Day - December 26, will have an additional holiday if this falls on a weekend

## Build and Run
* Xcode 11 & Swift 5
* Open BusinessDays.xcworkspace

## Architecture
### MVVM Architecture
* ViewModel contains the business logic, requests data from the local API
* ViewModels communicate with the ViewController using the delegate pattern. The ViewModel has a weak reference to a ViewModelDelegate which the ViewController implements.
* ViewModel communicates with the API via Actions. Action is an abstraction to a Service. The Action abstraction is used to mock the service in testing ViewModels. 
* ViewModel doesn't have direct knowledge or reference to the Holidays and Weekdays API.
* Tests make use of a Service stub to mock behavior. It uses a Delegate spy to verify interactions with the ViewController

### BusinessDaysService
* Responsible for communicating with the APIs and coordinating requests and responses. 
* Uses DispatchQueues to perform the processing in the background, since the APIs are asynchronous and it shouldn't be run on the Main queue. 
* Gets the number of weekdays and number of holidays in between those dates and computes business days from those values.
* Since there's logic in computation and handling the response from the APIs, Services is tested using API stubs.

### BusinessDays API
#### HolidayAPI
The HolidaysAPI provides an interface for the HolidayEngine. This is so it would be simpler to change to a different engine if most of the clients reference HolidaysAPI. Based on the dates, the engine gets the range of years and gets all the holidays of the year that falls inside the date range. It then counts the number of holidays based on the year range. 

##### List of Holidays for a year
Given an array of HolidayTypes and a date filter that determines the start and end date, it loops through all the holidays for the year and computes which date it falls thru. Depending on which holiday type it is, it either adjusts the date to the next weekday or doesn't include it if it falls on the weekend. If there is a given date filter, the engine verifies the date falls inside the date range before including it in the list of holidays. 

##### Holiday Types
HolidayType is what the HolidayAPI uses to compute for the holidays of a given year. It has 3 cases which are described below: 
* sameDate holidays happen on that date, if it falls on the weekend it doesn't add additional holidays
* sameDateOrNextWeekday holidays will have an additional holiday if it falls on the weekend
* dayInAMonth holidays don't have a specific date but rather is dependent on a certain week and day of the month

##### Future consideration
Aside from improving the holiday search and filter computations, another way to extend this is to allow more holidays from different states or countries. This is currently defaulted to use the defined NSW holidays. Different regions can define a list of holidays and pass it to the engine as an array of holiday types. 


#### WeekdaysAPI
The WeekdaysAPI provides an interface that clients can use in dealing with WeekdaysEngines. The Engine does the computation loops through all the dates starting on the From date up until the To date. It performs an isDateWeekend check and increments the weekday counter based on the results. 

##### Future consideration
Adding or experimenting with a new WeekdayEngine is straight forward. There is a WeekdaysAPITests that can be extended to have an array of engines. The new engine needs to conform to WeekdaysAPI. The tests would then be able to help verify if the implementation is correct. Aside from swapping out the current LoopDaysWeekdayEngine with the current one in the Service layer, no other change is needed when moving from the current approach.

A different way of implementing the weekday computations would be to do Date calculations based on the start and end dates and where they fall. This approach is more performant since there's no looping involved and it happens in constant time. The trade-off of doing this approach is that the code is more complex and more difficult to read because of the different scenarios and edge cases that need to be considered. 

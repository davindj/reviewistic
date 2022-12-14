# Reviewistic
![](./src-readme/reviewistic-1.png)

A native iOS app for retail business owners who want to collect customers' feedback from their transactions and give promos after the customers give their feedback.

## Background
There are a lot of business owners these days and many of them have the same common problem, and that problem is losing some customers without a clue. One way to solve this problem is to ask directly to the customers by survey, but here comes another problem. A lot of customers don't have the motivation to give feedback. Some business owners solve this by giving a reward to any customer that fills the survey.

Based on the problems that these business owners had, we formed the Reviewistic app as a solution. Reviewistic is an app aimed toward business owners to collect and read reviews from the customer after having a transaction.


## App Features
### See all the reviews
Business owners can see all the reviews they got from their customers based on each category.
### Voucher System
This system will make the customer want to give a review. Where in this system customers will receive a voucher after giving a review.
### Review in a simple, fast, and convenient way
Reviewistic use [Apps Clip experience](https://developer.apple.com/documentation/appstoreconnectapi/app_store/app_clips_and_app_clip_experiences), so the customer can experience the apps without even need to install them in the app store, just by scan QRcode generated by the business owner.

## Installation
setup for reviewistic app are divided into 
- Airtable installation for backend & database
- xcode Installation

### Airtable Installation
1. setup [airtable](https://airtable.com) workspace based on [reviewistic airtable template](https://airtable.com/shrY6eJ8sYcMNWL8z)
2. get airtable api url (something like `https://api.airtable.com/v0/YOUR_AIRTABLE_ID`). _notes: you can get airtable id in url of your airtable workspace_
3. get airtable api key. https://support.airtable.com/hc/en-us/articles/219046777-How-do-I-get-my-API-key-

### Xcode Installation
1. download / clone this project
2. open `reviewistic/reviewistic.xcodeproj` in [xcode](https://developer.apple.com/xcode/)
3. setup environment variables such as `AIRTABLE_URL` and `AIRTABLE_API_KEY` at Edit Scheme > _reviewistic_ > Run > Environment Variables.
4. build & run this project

## Notes
- if you want the app to run without using xcode, you need to setup hardcode `AIRTABLE_URL` and `AIRTABLE_API_KEY` in `reviewistic/reviewistic/Extension/Url.swift`  
    ```swift
    ...
    private static var AIRTABLE_URL: String {
        "https://api.airtable.com/v0/jassDK12DDsda" // <-- this one
    }
    private static var AIRTABLE_API_KEY: String {
        "keys7A1poLWvQm10A" // <-- and this one
    }
    ...
    ```

## See Also
- [customer app](https://github.com/davindj/reviewistic-customer) for reviewistic app
Original App Design Project
===

# Discount Discover

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
Discount Discover shows coupons and sales at nearby stores based on the user's current location. It notifies the user of deals when they are nearby a store that fits their preferences.

### App Evaluation
- **Category:** Shopping
- **Mobile:** This app makes use of maps and location to show the user deals nearby them. It also sends notifications of these deals.
- **Story:** This app makes it easy for users to find deals and decide where they might want to shop without having to go out of their way to look for them.
- **Market:** This app appeals to any individual who shops. This is a large potential user base.
- **Habit:** This app can be used any time the user wants to shop, which could be rather often.
- **Scope:** Building this app includes exploration of integrating a map SDK to find nearby stores, pulling the deals from a database or API, and creating a user profile with preferences. It could be expanded to create business profiles that can add deals.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can create new account/log in to access preference settings
* User can see a list of all stores within a certain radius that fit their preferences
* Tapping on a store shows all deals (get deals from database or API)
* Notification when nearby a store with deals that fits their preferences
* Settings (Account, Notifications)
* Profile with profile picture and preferences
* Map view where stores with deals are marked

**Optional Nice-to-have Stories**

* Users can submit deals for approval to be added
* Business profile that can add deals
* User can search stores

### 2. Screen Archetypes

* Login Screen
    * User can login
* Registration Screen
    * User can create a new account
* Profile
    * Upload profile photo
    * View and change preferences
* Stream - Nearby Stores
    * User can see a list of all stores within a certain radius that fit their preferences
* Map View
    * Stores with deals are marked
* Detail - Deals
    * Get deals from database or API
* Settings
    * Radius and notifications settings

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Deals
* Map View
* Profile

**Flow Navigation** (Screen to Screen)

* Login Screen
   * => Nearby Stores
* Registration Screen
   * => Preference Selection
   * => Nearby Stores
* Profile
   * => Settings
   * => Preference Selection
   * => Photo
* Stream - Nearby Stores
   * => Deals
* Map View
   * => Deals
* Detail - Deals
   * => None
* Settings
   * => None
   
## Wireframes
<img src="https://i.imgur.com/oLvl4M3" width=800>

# Project 2 - BeReal Clone (Part 1)

Submitted by: **Krystal Lewin**

**BeReal Clone** is a photo-sharing app that mimics the core features of BeReal. Users can register, log in, post a photo with a caption to a backend server, and view a feed of community posts.

Time spent: 8 hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can sign up to create a new account
- [x] User can log in and log out of their account
- [x] User can take or pick a photo from their library and add a caption
- [x] User can post photo to Back4App / Parse backend
- [x] User sees a feed of uploaded posts with photo, username, and caption
- [x] Feed supports pull-to-refresh to fetch new posts

The following **optional** features are implemented:

- [ ] Blur feed posts until user uploads within 24 hours
- [ ] Relative post timestamps

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img width="360" height="640" alt="Image" src="https://github.com/user-attachments/assets/572edef3-bc09-43bb-8f4c-85f443244f88" />
https://youtu.be/1pF9Z__hFNw

<!-- If using a hosted link instead of local file, replace 'demo.gif' with your URL -->

## Notes

Describe any challenges encountered while building the app (e.g., configuring storyboard segues, wiring custom table view prototype cells, managing navigation controller transitions).
Storyboard outlets (like tableView) weren't visible in the Connections Inspector. Resolving this required ensuring the @IBOutlet properties were accurately declared in the view controller code.
had trouble syncing asynchronous ParseSwift queries with the feed UI required careful dispatch handling.


## License

    Copyright [2026] [Krystal Lewin]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

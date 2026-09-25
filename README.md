# Project 3 - *BeReal Clone*

Submitted by: **Krystal Lewin**

**BeReal Clone** is a photo-sharing iOS app that recreates the core mechanics of BeReal using ParseSwift and Back4App, requiring users to post their own photo within 24 hours to unblur and view other users' posts in the feed.

Time spent: **6** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can launch camera to take photo instead of photo library
  - [x] Users without iPhones to demo this feature can manually add unique photos to their simulator’s Photos app
- [x] Posts have a time and location attached to them
- [x] Users are not able to see other users’ photos until they upload their own.

The following **optional** features are implemented:

- [ ] Posts have a comment section, which displays the commenter’s username and comment context
- [ ] User receives notification when it is time to post

The following **additional** features are implemented:

- [x] Pull-to-refresh control on the feed table view.
- [x] Target membership and custom schema handling for ParseUser `lastPostedDate`.

## Video Walkthrough

https://youtu.be/0Qg-n6g_nxk


## Notes

- Debugged a Back4App schema type mismatch (`Pointer<_User>` vs. `Object`) for the post creator relation.
- Resolved view hierarchy and constraint issues to ensure the `UIVisualEffectView` dynamically sizes and layers directly over `UIImageView` when loading remote images asynchronously.
- Implemented fallback logic for simulator environments lacking physical camera hardware.

## License

    Copyright [2026] [Krystal Lewin]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.# Project 2 - BeReal Clone (Part 1)

Submitted by: **Krystal Lewin**
---------------------------------------------------------------------------------------------------------------------
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

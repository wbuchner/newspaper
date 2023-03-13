# Chanel Nine Coding challenge

This challenge was constructed in SwiftUI iOS 16+ in XCode Version 14.2 with an MVVM architecture
There are three states to the UI

1. Loading
2. loaded([CategoryViewModel])
3. failure(RequestErrors)

![loading_states](https://user-images.githubusercontent.com/241315/224616954-c3fceb7b-6cd7-4cf2-aeb7-a2e20473b53d.png)
![ipad_loaded_state](https://user-images.githubusercontent.com/241315/224619717-38da1e8b-be5d-4e68-809a-d6dc830e2b95.png)

The `ArticlesViewModel` controls the viewState and UI switches the state in a container in the main `ContentView` to return the correct view.

`RequestErrors` enum was constructed to throw and identify specific api and decoding errors. These errors are specific to the Client, however a model could throw their own unique errors for JSON decoding etc, isolating it where the mapping of the error occurred for easier debugging or analytics.

The Client uses `async await` to send a simple request to the api and JSON Decodes the response and returns an array of `Articles` to the `ArticlesViewModel`. Why an [Articles], given there model shows Categories I make an assumption here that many catogories could be returned in the response.

I have included Unit tests for inspection that tests:
1. Model --> JSON parsing
2. ViewModel - loading states
3. ViewModel - sorting of articles
4. ViewModel - retrieving the smallest thumbnail url
5. Client (via a mock client)
6. Accessibility Tests

You can determine the process in which this application was built by interrogating the git log.

I used Proxyman to locally map the data from the api `[https://eacp.energyaustralia.com.au/codingtest/api/v1/festivals](https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full)`
# Success
To trigger `success` add `HTTP/1.1 200 OK`

# Failure
To trigger `failure` add `HTTP/1.1 400 Bad Request` to the header (or break the JSON)

### Dependency Acknowledgements
1. Kingfisher. I use Kingfisher in commercial applications. It is a lightweight native Swift Library with excellent caching abilities and is extremely simple to use.

## Outcome
#### A few known SwiftUI issues. Y
1. You may notice some Purple Warnings `this method should not be called on the main thread as it may lead to UI unresponsiveness.` 
   This a known swiftUI issue and is documented. It can be ignored.
![Screenshot 2023-03-14 at 9 58 09 am](https://user-images.githubusercontent.com/241315/224850881-dcbcd2ea-d332-4652-88c0-04b58e6b2de3.png)

2. Local strings. Given this is simple a coding challenge, for the limited number of strings required I opted to add them locally as opposed to setting up a Strings file.

3. I went overboard mapping the JSON respponse. I could have halved my time, but I noticed some interesting issues like custom coding keys and haven't needed to build solutions for them in a long time and enjoyed the challenge. 

## Suggestions
For any future code challenges, it would be nice to include a Data Model of the response. Many companies I have worked at supply a contract as the `Sole Truth`. I have added a link here for a swagger suggestion to include so there is no guess work building a model. It would also be nicer to not make everything `Optional`, you might notice that. I made the thumbnail URL mandatory, my assumption being there would be a simple resolution for missing thumbnail images built into the backend api. This [swagger](https://eacp.energyaustralia.com.au/codingtest/api-docs/) document was included in a previous Code Challenge.

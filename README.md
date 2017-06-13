# When

[![CI Status](http://img.shields.io/travis/SiarheiFedartsou/When.svg?style=flat)](https://travis-ci.org/SiarheiFedartsou/When)
[![Version](https://img.shields.io/cocoapods/v/When.svg?style=flat)](http://cocoapods.org/pods/When)
[![License](https://img.shields.io/cocoapods/l/When.svg?style=flat)](http://cocoapods.org/pods/When)
[![Platform](https://img.shields.io/cocoapods/p/When.svg?style=flat)](http://cocoapods.org/pods/When)

Lightweight library for waiting for completion of several concurrent tasks.

## Getting Started

Library works with asynchronous operations wrapped to `Job` struct. To wrap your asynchronous task just write:
```swift
func findPerson(byId id: String, completionHandler: @escaping (Result<Person, PersonError>) -> Void) {
// some asynchronous work
}
func findPersonJob(id: String) -> Job<Person> {
  return Job { onSuccess, onFailure in
    findPerson(byId: id) { result in
      switch result {
      case let .success(person):
        onSuccess(person)
      case let .failure(error):
        onFailure(error)
      }
    }
  }
}
```

Then you can use `when` function to wait for completion of several jobs:
```swift
 when(findPersonJob(id: "personA"), findPersonJob(id: "personB"), onSuccess: { personA, personB in
            // do something with `personA` and `personB`
        }, onError: { error in
            // handle error
        })
```

For cases when your asynchronous method signature is similar to `findPerson(byId:completionHandler:)` function above(list of parameters at the beginning, then completionHandler that takes `Result` type) `When` has special function `wrap` which allows easily wrap such methods to jobs:
```swift
when(wrap(findPerson(byId:completionHandler:))("personA"), 
     wrap(findPerson(byId:completionHandler:))("personB"), 
     onSuccess: { personA, personB in
            // do something with `personA` and `personB`
     }, 
     onError: { error in
            // handle error
     })
```
Also you can easily implement your own `wrap` functions. Just see [Wrap.swift](https://github.com/SiarheiFedartsou/When/blob/master/When/Classes/Wrap.swift) for example. Pull requests with new `wrap` functions are welcome!
## Requirements

## Installation

When is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "When"
```

## Author

SiarheiFedartsou, siarhei.fedartsou@gmail.com

## License

When is available under the MIT license. See the LICENSE file for more info.

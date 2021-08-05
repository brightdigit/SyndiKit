**STRUCT**

# `SyndicationUpdate`

```swift
public struct SyndicationUpdate: Codable, Equatable
```

Properties concerning how often it is updated a feed is updated.

These properties come from
 [the RDF Site Summary Syndication Module](https://web.resource.org/rss/1.0/modules/syndication/).

## Properties
### `period`

```swift
public let period: SyndicationUpdatePeriod
```

Describes the period over which the channel format is updated.
The default value is ``SyndicationUpdatePeriod/daily``.

### `frequency`

```swift
public let frequency: Int
```

Used to describe the frequency of updates in relation to the update period.
The default value is 1.

A positive integer indicates how many times in that period the channel is updated.
For example, an updatePeriod of daily, and an updateFrequency of 2
indicates the channel format is updated twice daily.

### `base`

```swift
public let base: Date?
```

Defines a base date
to be used in concert with
``SyndicationUpdate/period``  and ``SyndicationUpdate/frequency``
 to calculate the publishing schedule.

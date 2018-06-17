# Considerations

These are some of the things you'll need to think about when implementing a
reservation system.

## Features

### Reservation

* How do you prevent the same people from reserving the same thing?
* Is a unit's check-in and check-out time relevant?
* Is a unit's timezone relevant?
* Can an owner specify a minimum or maximum reservation duration?
* Can a guest reserve more than one unit for an intersecting time interval?
* Can a guest cancel a reservation?
* Can a guest modify a reservation in any way once it has begun?
* Can a guest create a reservation retroactively? (e.g. start or end in the past)

### Location

* How do you find things in a geographic area?
* Where do you obtain location data?
* Can a unit's location change?

### Time

* How do people specify moments in time?
* How do you store time values?
* How do you present time values?

### Pricing

* How do you handle monetary values?
* How do you handle price changes?
* What happens to existing reservations if the price changes?

### Images

* How do you handle imagery for a unit?
* What limits do you impose of imagery?

### Availability

* How do you give owners a way to make unit available or unavailable for periods
  of time?

## Implementation Details

### Security

* How do you authenticate a visitor's identity?
* What do you remember about a user?
* What can you forget about a user?
* How do you authorize actions?
* How do you handle security for a separate user interface? (e.g. JS-SPA)
* How do you review the application for potential security vulnerabilities?
* How do you secure communication between the client and server?
* How would you provide for SSL in a development environment?

### Auditing

* How do you keep track of who-did-what?

### Logging

* What do you log?
* How do you log it?
* How do you prevent sensitive data from leaking into logs?

### Persistence

* Is any business logic enforced at the persistence layer?
* Should new properties require schema modifications?
* How do you handle things like uploaded images?
* Is the system compliant with regulations like GDPR?

### Caching

* What is cached?
* Where is it cached?
* How is a cache invalidated?

### Testing

* How do you test features?
* How do you construct test data?
* How do you enforce conventions?
* How do you detect (and prevent) security problems?
* How do you perform continuous integration?

### Configuration

* How do you store configuration values? (e.g. API keys, credentials, etc...)

### Organization

* How do you provide different behaviors and views for the same conceptual things
  for different types of visitors? (e.g. guest vs. owner view of a unit)

### User Interfaces

* What devices can you use to interact with the system?

### Deployment

* How do you deploy a Rails application?

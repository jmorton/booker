# Data Model

The system exposes data about Guests, Owners, Units, and Reservations.

## Guest

Someone that wants to occupy a unit for a specific period of time.

## Owner

Someone that has a place for guests to reserve.

## Identity

Data about an authenticated visitor of the site. This provides separation between data about a person and data about what has happened. The primary motivation for this separation is to demonstrate how an app can forget who did something without forgetting that something happened.

## Unit

A place that can be occupied for various intervals of time by different guests.

Units are geocoded whenever their address is changed in order to support location based queries.

## Reservation

A date-interval exclusive relationship between a guest and a unit. A valid guest, unit, and duration are required.

## Audits

The system keeps old versions of entities to assist system operators with insight about what people are doing and to help resolve potential disputes.

## Search

A model that contains a place, start date, and end date used to find available units. This model is not persisted.

